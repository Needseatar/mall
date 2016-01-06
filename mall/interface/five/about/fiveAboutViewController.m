//
//  fiveAboutViewController.m
//  mall
//
//  Created by Mihua on 21/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fiveAboutViewController.h"

#define tabelLogoInterval 20
#define companyAndWebBGHeight 100

@interface fiveAboutViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray     *array;
@property (retain, nonatomic) UIView      *bgCompanyView;
@property (retain, nonatomic) UIView      *bgLogoAndVersion;

@end


@implementation fiveAboutViewController


#pragma mark - 设置按钮显示 返回
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES; //设置标签栏隐藏
    UISearchBar *searchView = [self.navigationController.navigationBar viewWithTag:30];
    searchView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setLogo];
    
    [self setData]; //初始化数据
    
    [self setNavigationController]; // 设置导航栏
    
    [self setTabel];  //设置tabel
    
    [self companyAndWeb];  //设置下面的地址和网站
}

-(void)setData
{
    _array = [[NSArray alloc] initWithObjects:@"关于我们",
                                              @"联系我们",
                                              @"合作及洽谈",
                                              @"用户服务协议",nil];
}

-(void)setLogo
{
    self.bgLogoAndVersion = [[UIView alloc] initWithFrame:CGRectMake(0, Navigation+UpState, self.view.frame.size.width, 130)];
    self.bgLogoAndVersion.backgroundColor = [UIColor clearColor];
    
    //logo和版本背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-120/2.0, 20, 120, 110)];
    bgView.backgroundColor = [UIColor clearColor];
    [self.bgLogoAndVersion addSubview:bgView];
    
    //logo
    UIImageView *imageLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(bgView.frame.size.width/2.0 - 80/2.0, 0, 80, 80)];
    imageLogoView.image = [UIImage imageNamed:@"icon@2x.png"];
    [bgView addSubview:imageLogoView];
    
    //版本号
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 120, 20)];
    versionLabel.font = [UIFont systemFontOfSize:15];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.text = @"当前版本:1.0.0";
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:versionLabel];
    
    [self.view addSubview:self.bgLogoAndVersion];
}

#pragma mark - 设置导航栏
-(void)setNavigationController
{
    self.title = @"关于";
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
}

#pragma mark - 设置TabelView界面
-(void)setTabel
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Navigation+UpState+130+tabelLogoInterval, 320, 568-Navigation-UpState-130-tabelLogoInterval-companyAndWebBGHeight)style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _array.count;
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //设置右边箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色
    cell.textLabel.text = _array[indexPath.row];
    return cell;
    
}
//跳转到活动详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    abouCompanyViewController *adv = [[abouCompanyViewController alloc] init];
    [self.navigationController pushViewController:adv animated:YES];
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
//返回组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma - mark 设置下面的公司名称和网址
-(void)companyAndWeb
{
    //背景视图
    self.bgCompanyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-companyAndWebBGHeight, self.view.frame.size.width, companyAndWebBGHeight)];
    self.bgCompanyView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    [self.view addSubview:self.bgCompanyView];
    
    UILabel *webLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-10, 20)];
    webLabel.text = @"官方网站：http://shop.trqq.com/";
    webLabel.textColor = [UIColor darkGrayColor];
    [self.bgCompanyView addSubview:webLabel];
    
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(10, 40, self.view.frame.size.width-10, 20)];
    companyLabel.text = @"公司名称：广西泰润网络科技有限公司";
    companyLabel.textColor = [UIColor darkGrayColor];
    [self.bgCompanyView addSubview:companyLabel];
    
    UILabel *telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(10, 70, self.view.frame.size.width-10, 20)];
    telephoneLabel.text = @"电话号码：400-0852-562";
    telephoneLabel.textColor = [UIColor darkGrayColor];
    [self.bgCompanyView addSubview:telephoneLabel];
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
