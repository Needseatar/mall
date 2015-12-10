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


@end

@implementation fisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchBar]; //设置导航栏
    
    [self requestFisterView];
    
    [self setTabelView];  //设置tabel
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]];
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

#pragma mark - 加载tabel
-(void)setTabelView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMakeEx(0, 0, 320, 565) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //使用cell之前初始化
    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}
#pragma mark - 跳转到指定视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ;
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return widthEx(35);
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
        [self.tableView reloadData];
        
//        fisterData *eeeee =[fisterData setValueWithDictionary:dict];
//        fisterHome1 *ddd=[[fisterHome1 alloc] init];
//        ddd = eeeee.FHome[0];
//        fisterHome4 *eed=[[fisterHome4 alloc] init];
//        eed = eeeee.FHome[2];
//        //NSLog(@"%d", eeeee.FHome.count);
//        NSLog(@"%@", ddd.title);
//        NSLog(@"%@", eed.rectangle1_data);
//        NSLog(@"%@", [eeeee.FList[0] goods_name]);
        
        
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
