//
//  fisterViewController.m
//  mall
//
//  Created by Mihua on 19/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterViewController.h"


@interface fisterViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UISearchBar       *searchBar;
@property (retain, nonatomic) UITableView       *tableView;
@property (retain, nonatomic) fisterData        *fisterData;
@property (retain, nonatomic) NSMutableArray    *listData; //保存了goodslist的数据，每两个fisterList为一组，listData保存 了多组数据
@property (retain, nonatomic) UIView            *loadingiew; //加载加载视图
@property (retain, nonatomic) UIView            *errorNetWork; //加载没有网络视图
@property (retain, nonatomic) UILabel           *errorRefresh; //刷新失败视图

@end

@implementation fisterViewController

#pragma mark - 设置按钮显示 返回
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    UISearchBar *searchView = [self.navigationController.navigationBar viewWithTag:30];
    searchView.hidden =  NO;
    self.tabBarController.tabBar.hidden = NO;  //便签控制器不隐藏
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]]; //设置返回按钮颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchBar]; //设置导航栏
    
    [self requestFisterView]; //请求数据
    
    [self setTabelView];  //设置tabel
    
    [self setLoadingView]; //加载加载视图
    
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMakeNavigationEx(75, 0, 200, 40, changeWidth)];
    _searchBar.tag = 30;
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
    
    //左边logo
    UIButton * leftLogo = [UIButton buttonWithType:UIButtonTypeCustom];
    leftLogo.frame = CGRectMakeNavigationEx(0, 0, 40, 20, changeWidth);
    [leftLogo setImage:[UIImage imageNamed:@"home_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftLogoItem = [[UIBarButtonItem alloc] initWithCustomView:leftLogo];
    self.navigationItem.leftBarButtonItem = leftLogoItem;
    
    //右边二维码
    UIButton * rightCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    rightCamera.frame = CGRectMakeNavigationEx(0, 0, 20, 20, changeWidth);
    [rightCamera setImage:[UIImage imageNamed:@"barcode_normal.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightCameraItem = [[UIBarButtonItem alloc] initWithCustomView:rightCamera];
    self.navigationItem.rightBarButtonItem = rightCameraItem;

}

#pragma mark - 加载tabel
-(void)setTabelView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, widthEx(320), heightEx(568)) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.hidden = YES;
    [self.view addSubview:_tableView];
    
    //设置下拉菜单
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self requestFisterView];
    }];
    
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    //如果需要带参数只能将该通知作为参数携带过去
    [center addObserver:self selector:@selector(notice:) name:@"mallID" object:nil];
    
    NSNotificationCenter * centerFunction = [NSNotificationCenter defaultCenter];
    [centerFunction addObserver:self selector:@selector(function:) name:@"function" object:nil];
    
    NSNotificationCenter * centerHome4 = [NSNotificationCenter defaultCenter];
    [centerHome4 addObserver:self selector:@selector(home:) name:@"Home4" object:nil];
}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1)
    {
        return self.fisterData.FHome.count;
    }else
    {
        return self.listData.count;
    }
    
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellId = @"cell";
        fisterBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[fisterBrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if(indexPath.section == 1)  //home1和home4样式
    {
        //判断数组里面的类是不是fisterHome1类
        if ([self.fisterData.FHome[indexPath.row] isKindOfClass:[fisterHome1 class]]) {  //home1 样式
            static NSString * cellId2 = @"cell2";
            fisterHome1TableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellId2];
            if(cell2 == nil){
                cell2 = [[fisterHome1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
                cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.backgroundColor = [UIColor whiteColor];
            
            [cell2 setTextAndImage:self.fisterData.FHome[indexPath.row]];
            return cell2;
        }else        //home4样式
        {
            static NSString * cellId3 = @"cell3";
            fisterHome4TableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellId3];
            if(cell3 == nil){
                cell3 = [[fisterHome4TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId3];
                cell3.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell3.selectionStyle = UITableViewCellSelectionStyleNone;
            cell3.backgroundColor = [UIColor whiteColor];
            
            [cell3 setTextAndImage:self.fisterData.FHome[indexPath.row]];
            
            return cell3;
        }
        
    }else
    {
        static NSString * cellId4 = @"cell4";
        fisterListerTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:cellId4];
        if(cell4 == nil){
            cell4 = [[fisterListerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId4];
            cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        cell4.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1];
        
       [cell4 setTextAndImage:self.listData[indexPath.row]];
        return cell4;
    }

}
#pragma mark - 跳转到指定视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if ([self.fisterData.FHome[indexPath.row] isKindOfClass:[fisterHome1 class]]) {
            fisterHome1 *home1 = self.fisterData.FHome[indexPath.row];
            NSString *str = home1.data;
            NSLog(@"%@", str);
            NSRange range = [str rangeOfString:@"goods_id"];//匹配得到的下标
            str = [str substringFromIndex:(range.location+range.length)];
            NSLog(@"%@", str);
            range = [str rangeOfString:@"="];
            str = [str substringFromIndex:(range.location+range.length)];
            
            //视图跳转
            goodInformationViewController *GInformation = [[goodInformationViewController alloc] init];
            GInformation.goods_id = [str integerValue];
            [self.navigationController pushViewController:GInformation animated:YES];
        }
    }
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return heightEx(150);
    }else if (indexPath.section == 1)
    {
        if ([self.fisterData.FHome[indexPath.row] isKindOfClass:[fisterHome1 class]]) {
            fisterHome1 *FHome1 = self.fisterData.FHome[indexPath.row];
            if ([FHome1.title length] == 0) { //home1 没有标题的高度
                return heightEx(153);
            }else
            {
                return heightEx(183);
            }
        }else  //home4 类的高度
        {
            return heightEx(153);
        }
        
    }else
    {
        return heightEx(230);
    }
}


#pragma mark - 请求首页数据
-(void)requestFisterView
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:fisterRequest parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        
        self.fisterData = [fisterData setValueWithDictionary:dict];
        //打包数据
        self.listData = [[NSMutableArray alloc] init];
        int h=0;
        NSMutableArray *twoListArray;
        for (int i=0; i<self.fisterData.FList.count; i++) {
            //将完整的数据打包成每两个一组
            if (h==1) {
                [twoListArray addObject:self.fisterData.FList[i]];
                h=0;
                [self.listData addObject:twoListArray];
                continue;
            }else
            {
                twoListArray = [[NSMutableArray alloc] init];
                [twoListArray addObject:self.fisterData.FList[i]];
                h++;
            }
        }
        if (h==1) { //当是最后一个是单个的时候
            [self.listData addObject:twoListArray];
        }
        
        [self.loadingiew removeFromSuperview];
        self.tableView.hidden = NO;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];//结束刷新状态
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if ([self.fisterData isKindOfClass:[fisterData class]]) { //判断有没有数据
            [self.tableView.mj_header endRefreshing];
            
            if (self.errorRefresh==nil) {
                self.errorRefresh = [loadingImageView setNetWorkRefreshError:self.view.frame viewString:@"刷新失败"];
                [self.view addSubview:self.errorRefresh];
                [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
            }
        }else
        {
            [self.loadingiew removeFromSuperview];
            CGRect fr = CGRectMake(self.view.frame.size.width/2.0-300/2.0, self.view.frame.size.height/2.0-300/2.0, 300, 300);
            self.errorNetWork = [loadingImageView setNetWorkError:fr];
            UIButton *but = [self.errorNetWork viewWithTag:7777];
            [but addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.errorNetWork];
        }
    }];
}
-(void)setStoplabel
{
    [self.errorRefresh removeFromSuperview];
    self.errorRefresh = nil;
}

#pragma mark - 加载加载视图
-(void)setLoadingView
{
    CGRect fr = CGRectMake(self.view.frame.size.width/2.0-40, self.view.frame.size.height/2.0-40, 80, 80);
    self.loadingiew = [loadingImageView setLoadingImageView:fr];
    
    [self.view addSubview:self.loadingiew];
}

-(void)buttonAction
{
    [self.errorNetWork removeFromSuperview];
    [self setLoadingView]; //加载加载视图
    [self requestFisterView];
}

#pragma mark - 设置最后的listcell的跳转
-(void)notice:(NSNotification *)notification{
    goodInformationViewController *GInformation = [[goodInformationViewController alloc] init];
    fisterList *FL= [notification object];
    GInformation.goods_id = [FL.goods_id integerValue];
    [self.navigationController pushViewController:GInformation animated:YES];
}
#pragma mark - 设置泰润商城按钮
-(void)function:(NSNotification *)notification{
    NSString *str = [notification object];
    NSArray *nameArray = @[@"万能居", @"泰润酒店", @"大浪淘沙酒店", @"战略联盟商家",
                           @"所有店铺", @"所有商品", @"帮助中心", @"反馈留言"];
    
    //跳转
    if ([str isEqualToString:nameArray[0]]) {
        
    }else if ([str isEqualToString:nameArray[1]])
    {
        
    }else if ([str isEqualToString:nameArray[2]])
    {
        
    }else if ([str isEqualToString:nameArray[3]])
    {
        
    }else if ([str isEqualToString:nameArray[4]])
    {
        
    }else if ([str isEqualToString:nameArray[5]])
    {
        
    }else if ([str isEqualToString:nameArray[6]])
    {
        
    }else if ([str isEqualToString:nameArray[7]])
    {
        
    }else
    {
        
    }
    
}

#pragma mark - 搜索栏跳转
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    self.tabbarControl.selectedIndex = 2;
    return NO;
}

-(void)home:(NSNotification *)notifica
{
    NSString *str = [notifica object];
    //视图跳转
    goodInformationViewController *GInformation = [[goodInformationViewController alloc] init];
    GInformation.goods_id = [str integerValue];
    [self.navigationController pushViewController:GInformation animated:YES];
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
