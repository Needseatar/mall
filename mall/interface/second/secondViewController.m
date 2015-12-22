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
 * 5.thirdArray的下标保存的是当前页面每一组数据，也是一个array，而此array保存的是每一个cell里面的数据
 * 6.每个cell里面的数据是一个array，此array保存了1到三个thirClassification对象
 *
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

@property (assign, nonatomic) NSInteger               page; //当page更新时候，就更新tableView,和更新滚动视图上的tabel，如果数据请求失败,将再次请求
@property (assign, nonatomic) NSInteger               pageID; //当page更新时候，保存了page请求二级数据的id，当当前id请求失败时，pageID将置0；
@property (retain, nonatomic) NSMutableArray    *thirdArray; //保存了当前页面的所有三级数据

@end

@implementation secondViewController

-(void)viewWillAppear:(BOOL)animated
{
    UISearchBar *searchView = [self.navigationController.navigationBar viewWithTag:30];
    searchView.hidden = NO;                     //搜索不隐藏
    self.tabBarController.tabBar.hidden = NO;  //便签控制器不隐藏
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestClassification]; //请求一级数据
    
    [self createSearchBar];   //设置导航栏的搜索和取消
    
    [self setpageOfTabel]; //设置tabel有没有参数，和接收cell里面的数据
    
    [self setTabelView];  //加载table一级分类tabel
    
}

-(void)setpageOfTabel
{
    //接收在cell里面点击时候，传会点击方块的id
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(ComeBacksquareStringID:) name:@"squareStringID" object:nil];
    self.whetherNowArray = NO;  //设置tabel没有更新
    if (self.bgTableScrollView != nil) {
        UITableView *scTabel = (UITableView *)[self.bgTableScrollView viewWithTag:self.page+100];
        self.whetherNowArray = YES;  // 当二级数据请求回来的时候，立刻知道当前页面二级数据已经实时跟新了
        [scTabel reloadData];
    }
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMakeEx(20, 7, 260, 20)];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.tag = 30;
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
            secondTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.bgTableScrollView addSubview:secondTabel];
        }
    }

}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return  self.OCassification.count;
    }else if (tableView == (UITableView *)[self.bgTableScrollView viewWithTag:self.page+100])
    {
        if (self.whetherNowArray == YES) {
            if (self.thirdArray.count == 0) {
                return 1;
            }else
            {
                if (self.thirdArray.count-1 >= section) {
                    return [self.thirdArray[section] count]+1;
                }else
                {
                    return 1;
                }
            }
        }else
        {
            return 0;
        }
    }else
    {
        return 0;
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
//返回组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
//返回组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == (UITableView *)[self.bgTableScrollView viewWithTag:self.page+100]) {
        if (section == 0) {
            return 0.1;
        }
    }else if (self.tableView == tableView)
    {
        return 0.1;
    }
    return 6;
}
#pragma mark - 返回cell的样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        //初始化一级数据的cell
        static NSString * cellId1 = @"cell1";
        secondMainTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellId1];
        if(cell1 == nil){
            cell1 = [[secondMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
        }
        //使用cell之前初始化
        cell1.bgLabel.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
        cell1.bgLabel.textColor = [UIColor blackColor];
        
        //功能是判断滚动视图是否有变,如果有变，先init所有cell，然后给指定的cell选中
        //根据实时的_page请求page的数据
        if (_page == indexPath.row) {
            cell1.bgLabel.backgroundColor = [UIColor whiteColor];
            cell1.bgLabel.textColor = [UIColor redColor];
            self.pageID = [self.OCassification[self.page] gc_parent_id];
#pragma mark - 请求二级数据
            if (self.whetherNowArray == NO) { //如果没有数据就请求数据二级数据
                [self requestSecondClassification:[self.OCassification[self.page] gc_parent_id]]; //请求二级数据，并把id只也传递过去
            }
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.bgLabel.text = [self.OCassification[indexPath.row] gc_name];
        return cell1;
    }else
    {
        //初始化第二级数据的cell
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

        //当数据是实时请求回来的数据的时候，才实时更新
        if (self.whetherNowArray == YES)
        {
            if (self.thirdArray.count == 0) {
                self.thirdArray = [[NSMutableArray alloc] init];
#pragma mark - 请求三级数据
                [self requestSecondClassification:[self.nowArray[indexPath.section] gc_parent_id]];
            }else
            {
#pragma mark - 初始化第三级数据的cell
                static NSString *cellID2 = @"cell2";
                secondTwoTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellID2];
                if(cell2 == nil){
                    cell2 = [[secondTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
                }
                cell2.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if (self.thirdArray.count < indexPath.section) {  //当indexPath.section没有数据时，就请求数据
                    [self requestSecondClassification:[self.nowArray[indexPath.section] gc_parent_id]];
                }
                
#pragma mark - 加载第三级数据
                if (self.thirdArray.count-1 >= indexPath.section) {
                    if (indexPath.row == 0) {
                        //设置第二级数据的标题
                        cell.textLabel.text = [self.nowArray[indexPath.section] gc_name];
                        return cell;
                    }else
                    {
                        //设置三级数据
                        NSArray *ar = self.thirdArray[indexPath.section];
                        [cell2 settextLabel:ar[indexPath.row-1]];
                        return cell2;
                    }
                }
            }
            //设置第二级数据的标题
            cell.textLabel.text = [self.nowArray[indexPath.section] gc_name];
        }
        return cell;
    }

}
#pragma mark - 一级数据tabelView跳转到指定滚动视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        [self.bgTableScrollView setContentOffset:CGPointMake(220*indexPath.row, 0) animated:YES];
        self.page = indexPath.row;
        self.whetherNowArray = NO;
        self.thirdArray = [[NSMutableArray alloc] init]; //初始化当前页面的第三级数据
        [self.tableView reloadData]; //点击的tabel刷新
    }
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView != self.tableView) {
        if (indexPath.row != 0) {
            return heightEx(70);
        }else
        {
            return heightEx(35);
        }
    }else
    {
        return heightEx(35);
    }
}
#pragma mark - 背景滚动视图代理
//当滚动视图停止时执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.bgTableScrollView == scrollView) {
        self.whetherNowArray = NO;
        self.thirdArray = [[NSMutableArray alloc] init]; //初始化当前页面的第三级数据
        self.page = scrollView.bounds.origin.x/220;
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
-(void)requestSecondClassification:(NSInteger)gc_parent_id
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:[NSString stringWithFormat:STClassification, (long)gc_parent_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        
        int requestID= [self comeBackID:[NSString stringWithFormat:@"%@", operation.request.URL]];
        //把请求回来的数据的指针给self.nowArray
        if (requestID == [self.OCassification[self.page] gc_parent_id]) { //判断实时page的id和请求的id是否一致
            self.nowArray = [oneClassification setValueWithDictionary:dict];
            UITableView *scTabel = (UITableView *)[self.bgTableScrollView viewWithTag:self.page+100];
            self.whetherNowArray = YES;  // 当二级数据请求回来的时候，立刻知道当前页面二级数据已经实时跟新了
            [scTabel reloadData];
#pragma mark - 当二级数据请求回来的时候，开启请求三级数据的第一组数据
            if (self.nowArray.count != 0) {
                [self requestSecondClassification:[self.nowArray[0] gc_parent_id]];
            }
        }else        //三级数据返回
        {
            if (self.whetherNowArray == YES)
            { //判断是不是还停在当前页面
                if (self.thirdArray.count <= self.nowArray.count)
                { //只有当nowArray有组的时候才会有id
                    if (self.thirdArray.count==0 && [self.nowArray[0] gc_parent_id]==requestID)
                    {
                        self.thirdArray = [[NSMutableArray alloc] init];
                        [self.thirdArray addObject:[thirClassification setValueWithDictionary:dict]];
                        UITableView *scTabel = (UITableView *)[self.bgTableScrollView viewWithTag:self.page+100];
                        [scTabel reloadData];
#pragma mark - 当三级数据第一组数据请求回来的时候，开启请求三级数据的第二组数据
                        if (self.nowArray.count > 1)
                        {
                            [self requestSecondClassification:[self.nowArray[self.thirdArray.count] gc_parent_id]];
                        }
                    }else
                    {
                        if (self.nowArray.count > self.thirdArray.count) {
                            
                            if ([self.nowArray[self.thirdArray.count] gc_parent_id]==requestID) {
                                [self.thirdArray addObject:[thirClassification setValueWithDictionary:dict]];
                                UITableView *scTabel = (UITableView *)[self.bgTableScrollView viewWithTag:self.page+100];
                                [scTabel reloadData];
                                if (self.nowArray.count > self.thirdArray.count) { //只有nowArray大于才请求，否则只付值
                                    [self requestSecondClassification:[self.nowArray[self.thirdArray.count] gc_parent_id]];
                                }
                            }
                        }
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        //二级数据请求失败处理
        int requestID= [self comeBackID:[NSString stringWithFormat:@"%@", operation.request.URL]];
        //把请求回来的数据的指针给self.nowArray
        if (requestID == [self.OCassification[self.page] gc_parent_id])
        {
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(requestSecond) userInfo:nil repeats:NO];
        }
    }];
}
-(void)requestSecond
{
    [self requestSecondClassification:[self.OCassification[self.page] gc_parent_id]]; //请求二级数据，并把id只也传递过去
}
#pragma mark - 当方块点击时，接收cell返回的方块id数据,并且跳到secondListViewController页面
-(void)ComeBacksquareStringID:(NSNotification *)notification
{
    NSString *gc_string_ID = [notification object];
    NSInteger gc_ID = [gc_string_ID integerValue];
    secondListViewController *SLViewControl = [[secondListViewController alloc] init];
    SLViewControl.gc_ID = gc_ID;
    SLViewControl.title = @"商品列表";
    [self.navigationController pushViewController:SLViewControl animated:YES];
}

-(int)comeBackID:(NSString *)string
{
    NSString *str = [string substringFromIndex:60];
    return [str intValue];
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
