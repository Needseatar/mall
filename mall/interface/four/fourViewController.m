//
//  fourViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//

#import "fourViewController.h"


#define shopDistance 10

@interface fourViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) NSMutableArray *dataArray;
@property (retain, nonatomic) UISearchBar    *searchBar;
@property (retain, nonatomic) UITableView    *shopingTabel;

@end

@implementation fourViewController

#pragma mark - 设置按钮显示 返回
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"购物车" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self requestShoppingCart];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchBar]; //设置导航栏
    
    [self setNotGoodsView];  //设置没有登录时候界面
    
    [self.view setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1]];
    [self setTabel];
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18],NSFontAttributeName, nil]];
    
    self.title = @"购物车";
    
}

-(void)setNotGoodsView
{
    
    UIImageView *ShoppingCart = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-200/2.0, UpState+Navigation+shopDistance, 200, 200)];
    ShoppingCart.image = [UIImage imageNamed:@"error_cart.png"];
    [self.view addSubview:ShoppingCart];
    
    UILabel *shoppingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, UpState+Navigation+200+shopDistance, self.view.frame.size.width-10, 30)];
    shoppingLabel.text = @"你的购物车是空的";
    shoppingLabel.textAlignment = NSTextAlignmentCenter;
    shoppingLabel.font = [UIFont systemFontOfSize:13];
    shoppingLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:shoppingLabel];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, UpState+Navigation+200+40+shopDistance, self.view.frame.size.width-10, 20)];
    label.text = @"你登录后同步电脑与手机购物车中的商品";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
}

#pragma mark - 设置TabelView界面
-(void)setTabel
{
    for (UIView *vi in [self.view subviews]) {
        [vi removeFromSuperview];
    }
    
    self.shopingTabel = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568-TabBar)style:UITableViewStylePlain];
    self.shopingTabel.delegate = self;
    self.shopingTabel.dataSource = self;
    [self.view addSubview:self.shopingTabel];
    
}
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  2;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色
    
    
//    cell.textLabel.text = [self.dataArray[indexPath.row] store_name];
//    cell.textLabel.font = [UIFont systemFontOfSize:18];
//    
//    cell.detailTextLabel.text = [self.dataArray[indexPath.row] store_address];
//    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
//    cell.detailTextLabel.textColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
    
    return cell;
    
}
//跳转到商家
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ;
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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

#pragma mark - 请求购物车里面的商品
-(void)requestShoppingCart{
    
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    if ([signIn.key isKindOfClass:[NSString class]]) {
        [manager GET:[NSString stringWithFormat:ShoppingCartNetWork, [NSString stringWithFormat:@"&key=%@", signIn.key]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"JSON: %@", dict);
            
            self.dataArray = [shopingCarModel setValueWithDictionary:dict];
            
            NSLog(@"%@", [self.dataArray[0] store_name]);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            
        }];
    }else //没有令牌，也就是没有登录
    {
        
    }
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
