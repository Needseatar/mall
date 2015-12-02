//
//  secondViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//
/*
 * 当加载一级数据回来之后再请求二级数据，并且加载二级数据
 *
 * 并且加载二级tabel和滚动视图
 */


#import "secondViewController.h"

@interface secondViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UISearchBar       *searchBar;
@property (retain, nonatomic) NSArray           *OCassification;

@property (retain, nonatomic) UITableView       *tableView;
@property (retain, nonatomic) NSMutableArray    *arrayTabledata;  //保存了二级数据的对象
@property (retain, nonatomic) UIScrollView      *bgTableScrollView;
@property (assign, nonatomic) int               page; //当page更新时候，就更新tableView

@end

@implementation secondViewController

-(void)viewWillAppear:(BOOL)animated
{
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
            [secondTabel setBackgroundColor:[UIColor grayColor]];
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
        NSLog(@"%d", tableView.tag);
        NSLog(@"%d", self.OCassification.count);
        NSLog(@"%@", [self.OCassification[tableView.tag - 100] gc_name]);
        oneClassification *asdf= [[oneClassification alloc] init];
        asdf = self.OCassification[tableView.tag-100];
        NSLog(@"%d", asdf.secondClassificationarray.count);
        NSArray *dataArray = asdf.secondClassificationarray;
        return dataArray.count;
    }
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
        if (_page == indexPath.row) {
            cell1.bgLabel.backgroundColor = [UIColor whiteColor];
            cell1.bgLabel.textColor = [UIColor redColor];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.bgLabel.text = [self.OCassification[indexPath.row] gc_name];
        return cell1;
    }else
    {
        static NSString * cellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        NSArray *dataArray = [[NSArray alloc] initWithArray:[self.OCassification[tableView.tag-100] secondClassificationarray]];
        cell.textLabel.text = dataArray[indexPath.row];
        
        return cell;
    }

}
#pragma mark - 跳转到指定视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        [self.bgTableScrollView setContentOffset:CGPointMake(220*indexPath.row, 0) animated:YES];
        self.page = indexPath.row;
        [self requestSecondClassification:[self.OCassification[self.page] gc_parent_id]]; //点击tabel是请求的二级数据
        [self.tableView reloadData]; //点击的tabel刷新
        UITableView *scrTabel = (UITableView *)[self.bgTableScrollView viewWithTag:100+self.page];
        [scrTabel reloadData]; //选择到的tabelview刷新
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
        self.page = scrollView.bounds.origin.x/220;
        [self requestSecondClassification:[self.OCassification[self.page] gc_parent_id]];
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
#pragma mark - 请求二级数据
-(void)requestSecondClassification:(int)gc_parent_id
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:[NSString stringWithFormat:SecondClassification, gc_parent_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        
        //把请求回来的数据放到对象oneClassification的array中
        oneClassification *OC = self.OCassification[self.page];
        OC.secondClassificationarray = [oneClassification setValueWithDictionary:dict];
        NSLog(@"%d", [[self.OCassification[self.page] secondClassificationarray] count]);
        NSLog(@"%d", OC.secondClassificationarray.count);
        UITableView *scrTabel = (UITableView *)[self.bgTableScrollView viewWithTag:100+self.page];
        [scrTabel reloadData]; //选择到的tabelview刷新
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        //[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(requestClassification) userInfo:nil repeats:NO];
    }];
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
