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

@end

@implementation fisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchBar]; //设置导航栏
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self requestFisterView];
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMakeEx(65, 7, 200, 20)];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
    
    //左边logo
    UIButton * leftLogo = [UIButton buttonWithType:UIButtonTypeCustom];
    leftLogo.frame = CGRectMakeEx(0, 0, 40,20);
    [leftLogo setImage:[UIImage imageNamed:@"home_logo.9.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftLogoItem = [[UIBarButtonItem alloc] initWithCustomView:leftLogo];
    self.navigationItem.leftBarButtonItem = leftLogoItem;
    
    //右边二维码
    UIButton * rightCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    rightCamera.frame = CGRectMakeEx(0, 0, 20,20);
    [rightCamera setImage:[UIImage imageNamed:@"barcode_normal.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightCameraItem = [[UIBarButtonItem alloc] initWithCustomView:rightCamera];
    self.navigationItem.rightBarButtonItem = rightCameraItem;

}

//#pragma mark - 加载tabel
//-(void)setTabelView
//{
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMakeEx(0, 0, 100, 565) style:UITableViewStylePlain];
//    [_tableView setBackgroundColor:[UIColor whiteColor]];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [self.view addSubview:_tableView];
//}
//#pragma mark - tabelView代理
////返回表格的行数的代理方法
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (tableView == self.tableView) {
//        return  self.OCassification.count;
//    }else
//    {
//        return 1;
//    }
//}
////返回表格的组数的代理方法
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if (tableView == self.tableView) {
//        return 1;
//    }else
//    {
//        return self.nowArray.count;
//    }
//}
////获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView == self.tableView) {
//        static NSString * cellId1 = @"cell1";
//        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellId1];
//        if(cell1 == nil){
//            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
//        }
//        //使用cell之前初始化
//        cell1.bgLabel.backgroundColor = [UIColor grayColor];
//        cell1.bgLabel.textColor = [UIColor blackColor];
//        
//        //功能是判断滚动视图是否有变,如果有变，先init所有cell，然后给指定的cell选中
//        //根据实时的_page请求page的数据
//        if (_page == indexPath.row) {
//            cell1.bgLabel.backgroundColor = [UIColor whiteColor];
//            cell1.bgLabel.textColor = [UIColor redColor];
//            self.pageID = [self.OCassification[self.page] gc_parent_id];
//            if (self.whetherNowArray == NO) { //如果没有数据就请求数据二级数据
//                [self requestSecondClassification:[self.OCassification[self.page] gc_parent_id]]; //请求二级数据，并把id只也传递过去
//            }
//        }
//        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell1.bgLabel.text = [self.OCassification[indexPath.row] gc_name];
//        return cell1;
//    }else
//    {
//        static NSString *cellID = @"cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if(cell == nil){
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        }
//        //初始化数据
//        cell.textLabel.text = @"";
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
//        [cell setBackgroundColor:[UIColor whiteColor]];
//        
//        //当数据是实时请求回来的数据的时候，才实时更新
//        if (self.whetherNowArray == YES) {
//            cell.textLabel.text = [self.nowArray[indexPath.section] gc_name];
//            
//#pragma mark - 请求第三级数据
//            self.thirdpage = indexPath.section;
//            [self requestSecondClassification:[self.OCassification[self.thirdpage] gc_parent_id]]; //请求三级数据，并把id只也传递过去
//            
//        }
//        
//        return cell;
//    }
//    
//}
//#pragma mark - 跳转到指定视图
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView == self.tableView) {
//        [self.bgTableScrollView setContentOffset:CGPointMake(220*indexPath.row, 0) animated:YES];
//        self.page = indexPath.row;
//        self.whetherNowArray = NO;
//        [self.tableView reloadData]; //点击的tabel刷新
//    }
//}
////返回行高的代理方法
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return widthEx(35);
//}


#pragma mark - 请求首页数据
-(void)requestFisterView
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:fisterRequest parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
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
