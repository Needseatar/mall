//
//  secondViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//
/*
 * 1.当加载一级数据回来之后请求刷新tabel，并且加载滚动视图和tabel
 * 2.刷新tabel的过程中，那个cell更新了，立刻请求所在cell数据的id,数据回来之后立刻刷新所在更新后tabel的cell里面的滚动视图上的tabel
 * 3.当点击和左边的tabel或者滚动滚动视图，都会刷新tabel
 * 4.现在的一级接口经常不稳定，经常会出现域名解析错误
 *
 *                                 thirdDic(二级页面所在的所有数据,可以通过请求的id的key找到对应的nsarray)
 *                               //
 *                             //
 *                           //
 *                       nsarray(二级页面每一类里面的数据)
 *                        //
 *                    nsarray   (每一类里面每一个cell里面的数据)
 *
 */


#import "secondViewController.h"

@interface secondViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UISearchBar       *searchBar;
@property (retain, nonatomic) NSArray           *OCassification;

@property (retain, nonatomic) UITableView       *tableView;
@property (retain, nonatomic) NSArray           *nowArray;  //保存了当前滚动视图的一个tabel的二级数据
@property (assign, nonatomic) BOOL              whetherNowArray; //保存了当前的nowArray是否是当前视图的二级数据

@property (retain, nonatomic) UIScrollView      *bgTableScrollView;

@property (assign, nonatomic) int               page; //当page更新时候，就更新tableView,和更新滚动视图上的tabel
@property (assign, nonatomic) int               pageID; //当page更新时候，保存了page请求二级数据的id

@property (retain, nonatomic) NSMutableDictionary  *thirdDic; //保存了当前页面第三级的数据

@end

@implementation secondViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.thirdDic = [[NSMutableDictionary alloc] init];
    self.whetherNowArray = NO;
    [self requestClassification]; //请求一级数据
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchBar];   //设置导航栏的搜索和取消
    
    [self setTabelView];  //加载table一级分类tabel
    
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMakeEx(20, 7, 260, 20)];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
    
    //右边二维码
    UIButton * rightCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    rightCamera.frame = CGRectMakeEx(0, 0, 20,20);
    [rightCamera setImage:[UIImage imageNamed:@"barcode_normal.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightCameraItem = [[UIBarButtonItem alloc] initWithCustomView:rightCamera];
    self.navigationItem.rightBarButtonItem = rightCameraItem;
    
}
#pragma mark - 加载tabel
-(void)setTabelView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMakeEx(0, 0, 100, 565) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark - 设置二三级分类
-(void)setTabelViewOfSecondAndThird
{
    if (self.OCassification.count != 0) {
        self.bgTableScrollView = [[UIScrollView alloc] initWithFrame:CGRectMakeEx(100, 60, 220, 459)];
        [self.bgTableScrollView setBackgroundColor:[UIColor whiteColor]];
        self.bgTableScrollView.contentSize = CGSizeMakeEx(220*self.OCassification.count, 459);
        self.bgTableScrollView.pagingEnabled = YES;
        self.bgTableScrollView.delegate = self;
        [self.view addSubview:self.bgTableScrollView];
        for (int i=0; i<self.OCassification.count; i++) {
            UITableView *secondTabel = [[UITableView alloc] initWithFrame:CGRectMakeEx(i*220, 0, 220, 459) style:UITableViewStylePlain];
            [secondTabel setBackgroundColor:[UIColor whiteColor]];
            secondTabel.tag = 100+i;
            secondTabel.delegate = self;
            secondTabel.dataSource = self;
            [self.bgTableScrollView addSubview:secondTabel];
        }
    }

}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return  self.OCassification.count;
    }else
    {
        if (self.thirdDic.count != 0) {
            
            for (NSString *string in [self.thirdDic allKeys])
            {
                int inSectionID= [self.OCassification[section] gc_parent_id];
                int requestID = [string integerValue];
                if (inSectionID == requestID) {
                    NSArray *ar = self.thirdDic[@"string"];
                    for (int i=0; i<ar.count; i++)
                    {
                        if (i*3>=ar.count) {
                            return i+1;  //返回当组成员和组标题
                        }
                    }
                    return 1;
                }
            }
            
            return 1;
        }
        return 1;
    }
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tableView) {
        return 1;
    }else
    {
        return self.nowArray.count;
    }
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        static NSString * cellId1 = @"cell1";
        secondMainTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellId1];
        if(cell1 == nil){
            cell1 = [[secondMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
        }
        //使用cell之前初始化
        cell1.bgLabel.backgroundColor = [UIColor grayColor];
        cell1.bgLabel.textColor = [UIColor blackColor];
        
        //功能是判断滚动视图是否有变,如果有变，先init所有cell，然后给指定的cell选中
        //根据实时的_page请求page的数据
        if (_page == indexPath.row) {
            cell1.bgLabel.backgroundColor = [UIColor whiteColor];
            cell1.bgLabel.textColor = [UIColor redColor];
            self.pageID = [self.OCassification[self.page] gc_parent_id];
            if (self.nowArray.count == 0) {
                [self requestSecondClassification:[self.OCassification[self.page] gc_parent_id]]; //请求二级数据，并把id只也传递过去
            }
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.bgLabel.text = [self.OCassification[indexPath.row] gc_name];
        return cell1;
    }else
    {
        static NSString *cellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        //初始化数据
        cell.textLabel.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.textLabel.text = [self.nowArray[indexPath.section] gc_name];
        
        if (self.nowArray) {
            ;
        }
        NSLog(@"%@", self.thirdDic);
        if (self.whetherNowArray == YES &&
            tableView == [self.bgTableScrollView viewWithTag:self.page+100] &&
            self.thirdDic.count == 0)
        {
            //请求当前页面所有的三级数据
            NSLog(@"%d", self.nowArray.count);
            for (int i=0; i<self.nowArray.count; i++){
                [self requestSecondClassification:[self.nowArray[i] gc_parent_id]];
            }
        }
        
        return cell;
    }

}
#pragma mark - 跳转到指定视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        [self.bgTableScrollView setContentOffset:CGPointMake(220*indexPath.row, 0) animated:YES];
        self.page = indexPath.row;
        self.whetherNowArray = NO;
        [self.tableView reloadData]; //点击的tabel刷新
    }
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return widthEx(35);
}
#pragma mark - 背景滚动视图代理
//当滚动视图停止时执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.bgTableScrollView == scrollView) {
        self.whetherNowArray = NO;
        self.page = scrollView.bounds.origin.x/220;
//        self.nowArray = [[NSArray alloc] init];
        [self.tableView reloadData];
    }
}

#pragma mark - 请求一级数据
-(void)requestClassification
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:FisterClassification parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        self.OCassification = [oneClassification setValueWithDictionary:dict];
        [self.tableView reloadData];
        [self setTabelViewOfSecondAndThird]; //设置并加载滚动视图
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(requestClassification) userInfo:nil repeats:NO];
    }];
}
#pragma mark - 请求二级和三级数据
-(void)requestSecondClassification:(int)gc_parent_id
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:[NSString stringWithFormat:STClassification, gc_parent_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        int requestID= [self comeBackID:[NSString stringWithFormat:@"%@", operation.request.URL]];
        //把请求回来的数据的指针给self.nowArray
        if (requestID == [self.OCassification[self.page] gc_parent_id]) { //判断实时page的id和请求的id是否一致
            self.nowArray = [oneClassification setValueWithDictionary:dict];
            UITableView *scTabel = (UITableView *)[self.bgTableScrollView viewWithTag:self.page+100];
            self.whetherNowArray = YES;  // 当二级数据请求回来的时候，立刻知道当前页面二级数据已经实时跟新了
            [scTabel reloadData];
        }else if (self.whetherNowArray == YES) //如果是实时更新的数据，直接调用nowArray的数据
        {
            for (int i=0; i<self.nowArray.count; i++) { //把返回来的数据和id打包成字典给thirdDic
                if (requestID == [self.nowArray[i] gc_parent_id]) {
                    NSDictionary *di = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [oneClassification setValueWithDictionary:dict],
                                          [NSString stringWithFormat:@"%d", requestID], nil];
                    [self.thirdDic addEntriesFromDictionary:di];
                    UITableView *scTabel = (UITableView *)[self.bgTableScrollView viewWithTag:self.page+100];
                    self.whetherNowArray = YES;  // 当二级数据请求回来的时候，立刻知道当前页面二级数据已经实时跟新了
                    [scTabel reloadData];
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(requestClassification) userInfo:nil repeats:NO];
    }];
}

//-(void)set

-(int)comeBackID:(NSString *)string
{
    NSString *str = [string substringFromIndex:60];
    return [str integerValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
