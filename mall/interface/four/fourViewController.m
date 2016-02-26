//
//  fourViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//

#import "fourViewController.h"


#define shopDistance 10  //购物车和导航栏的间隔
#define tabelHead    30  //tabel组头的高度

#define SettlementHeight   60   //下面结算价格的高度

@interface fourViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) BOOL              settlement; //设置有没有tab
@property (retain, nonatomic) NSMutableArray    *dataArray;
@property (retain, nonatomic) UISearchBar       *searchBar;
@property (retain, nonatomic) UITableView       *shopingTabel;
@property (retain, nonatomic) UIView            *notShoping; //加载没有物品的视图

@property (retain, nonatomic) UIView            *bgSortView;


@property (retain, nonatomic) UIView            *loadingiew; //加载加载视图
@property (retain, nonatomic) UIView            *errorNetWork; //加载没有网络视图

@property (retain, nonatomic) NSArray           *sumShopingPace; //商品总价栏

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
    if ([self.navigationController.viewControllers count] == 1) {
        _settlement=YES;
        self.tabBarController.tabBar.hidden = NO; //设置标签栏隐藏
    }else //设置总价格的背景视图位置
    {
        _settlement=NO;
        self.tabBarController.tabBar.hidden = YES; //设置标签栏不隐藏
    }
    self.errorNetWork = nil;
    
    [self requestShoppingCart];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDataInit];
    
    [self createSearchBar]; //设置导航栏
    
    [self.view setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1]];
    
    [self setTabel];    //设置tabel
    
    [self setNotGoodsView];  //设置没有物品界面
    
    [self setErrorNetWork];  //设置没有网络界面
    
    [self setLoadingView]; //设置加载页面
    
    [self hideAllView];  //隐藏所有界面
    
    [self SetSettlementView]; //设置下面的购物价格
    
}

#pragma mark - 初始化数据
-(void)setDataInit
{
    if ([self.navigationController.viewControllers count] == 1) {
        _settlement=YES;
        self.tabBarController.tabBar.hidden = NO; //设置标签栏隐藏
    }else //设置总价格的背景视图位置
    {
        _settlement=NO;
        self.tabBarController.tabBar.hidden = YES; //设置标签栏不隐藏
    }
}

#pragma mark - 设置没有网络界面
-(void)setErrorNetWork
{
    CGRect fr = CGRectMake(self.view.frame.size.width/2.0-300/2.0, self.view.frame.size.height/2.0-300/2.0, 300, 300);
    self.errorNetWork = [loadingImageView setNetWorkError:fr];
    UIButton *but = [self.errorNetWork viewWithTag:7777];
    [but addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.errorNetWork];
}
-(void)buttonAction
{
    for (UIView *vi in [self.view subviews]) {
        vi.hidden = YES;
    }
    
}
#pragma mark - 加载加载视图
-(void)setLoadingView
{
    CGRect fr = CGRectMake(self.view.frame.size.width/2.0-40, self.view.frame.size.height/2.0-40, 80, 80);
    self.loadingiew = [loadingImageView setLoadingImageView:fr];
    
    [self.view addSubview:self.loadingiew];
}
#pragma mark - 隐藏所有界面
-(void)hideAllView
{
    for (UIView *vi in [self.view subviews]) {
        vi.hidden = YES;
    }
}
#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18],NSFontAttributeName, nil]];
    
    self.title = @"购物车";
    
}
#pragma mark - 没有物品界面
-(void)setNotGoodsView
{
    self.notShoping = [[UIView alloc] initWithFrame:self.view.frame];
    self.notShoping.hidden = YES;
    
    UIImageView *ShoppingCart = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-200/2.0, UpState+Navigation+shopDistance, 200, 200)];
    ShoppingCart.image = [UIImage imageNamed:@"error_cart.png"];
    [self.notShoping addSubview:ShoppingCart];
    
    UILabel *shoppingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, UpState+Navigation+200+shopDistance, self.view.frame.size.width-10, 30)];
    shoppingLabel.text = @"你的购物车是空的";
    shoppingLabel.textAlignment = NSTextAlignmentCenter;
    shoppingLabel.font = [UIFont systemFontOfSize:13];
    shoppingLabel.backgroundColor = [UIColor clearColor];
    [self.notShoping addSubview:shoppingLabel];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, UpState+Navigation+200+40+shopDistance, self.view.frame.size.width-10, 20)];
    label.text = @"你登录后同步电脑与手机购物车中的商品";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.backgroundColor = [UIColor clearColor];
    [self.notShoping addSubview:label];
    
    [self.view addSubview:self.notShoping];
    
}

#pragma mark - 设置TabelView界面
-(void)setTabel
{
    if (_settlement == YES) {
        self.shopingTabel = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-SettlementHeight) style:UITableViewStylePlain];
    }else
    {
        self.shopingTabel = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+TabBar-SettlementHeight) style:UITableViewStylePlain];
    }
    self.shopingTabel.delegate = self;
    self.shopingTabel.dataSource = self;
    self.shopingTabel.hidden = YES;
    [self.view addSubview:self.shopingTabel];
    
}
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cell";
    fourTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[fourTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色
    cell.backgroundColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1];
    
    [cell setTextAndImage:self.dataArray fram:self.view.frame cellForRowAtIndexPath:indexPath];
    
    
    return cell;
    
}
//跳转到商家
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    goodInformationViewController *goodsView = [[goodInformationViewController alloc] init];
    shopingCarModel *shoping = self.dataArray[indexPath.section];
    goodsView.goods_id = shoping.goods_id;
    [self.navigationController pushViewController:goodsView animated:YES];
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
//返回组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (self.dataArray.count>0 && section==self.dataArray.count-1) {
//        return SettlementHeight;
//    }
    return 0.01;
}
//返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tabelHead;
}
//返回组头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgHeaderView = [[UIView alloc] init];
    bgHeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width-10, tabelHead)];
    titleLabel.text = [self.dataArray[section] store_name];
    [bgHeaderView addSubview:titleLabel];
    
    return bgHeaderView;
}
#pragma mark - 编辑删除table
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

/*改变删除按钮的title*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删";
}

/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
        shopingCarModel *shoping = self.dataArray[indexPath.section];
        if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
            NSDictionary *signInAddShoppingCar =
            [NSDictionary dictionaryWithObjectsAndKeys:
             signIn.key, @"key",
             [NSString stringWithFormat:@"%ld", (long)shoping.cart_id], @"cart_id", nil];
            [manager POST:DelectShopping parameters:signInAddShoppingCar success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"JSON: %@", dict);
                
                if ([dict[@"datas"] integerValue] == 1) {
                    [self.dataArray removeObjectAtIndex:[indexPath section]];  //删除数组里的数据
                    [self.shopingTabel deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]  withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应的组数
                    if (self.dataArray.count == 0) {//显示购物车为空
                        [self hideAllView];
                        self.notShoping.hidden = NO;
                    }
                }else
                {
                    if (self.errorNetWork==nil) {
                        CGRect fr = self.view.frame;
                        fr.size.height = self.view.frame.size.height-SettlementHeight;
                        self.errorNetWork = [loadingImageView setNetWorkRefreshError:fr viewString:@"删除失败"];
                        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
                        [self.view addSubview:self.errorNetWork];
                    }
                }
                
            }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                NSLog(@"Error: %@", error);
            }];
        }else //没有令牌，也就是没有登录
        {
            [self hideAllView];
            self.notShoping.hidden = NO;
        }
    }
}

#pragma mark - 请求购物车里面的商品
-(void)requestShoppingCart{
    
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
        [self hideAllView];
        self.loadingiew.hidden = NO;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *signInAddShoppingCar =
        [NSDictionary dictionaryWithObjectsAndKeys:
         signIn.key, @"key",
         nil];
        [manager POST:ShoppingCartNetWork parameters:signInAddShoppingCar success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"JSON: %@", dict);
            
            self.dataArray = [shopingCarModel setValueWithDictionary:dict];
            
            [self.shopingTabel reloadData];
            [self hideAllView];
            if (self.dataArray.count==0) {
                self.notShoping.hidden = NO;
            }else
            {
                self.shopingTabel.hidden = NO;
                self.bgSortView.hidden = NO;
            }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"Error: %@", error);
        }];
    }else //没有令牌，也就是没有登录
    {
        [self hideAllView];
        self.notShoping.hidden = NO;
    }
}

-(void)SetSettlementView
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.bgSortView = [[UIView alloc] init];
    if (_settlement == YES) {
        self.bgSortView.frame = CGRectMake(0, self.view.frame.size.height-TabBar-SettlementHeight, self.view.frame.size.width, SettlementHeight);
    }else
    {
        self.bgSortView.frame = CGRectMake(0, self.view.frame.size.height-SettlementHeight, self.view.frame.size.width, SettlementHeight);
    }
    self.bgSortView.hidden = YES;
    [self.bgSortView setBackgroundColor:[UIColor colorWithRed:248.0/255.0f green:249.0/255.0f blue:250.0/255.0f alpha:1]];
    [self.view addSubview:self.bgSortView];
    
    self.sumShopingPace = @[@"总计:￥0.00元", @"去结算"];
    
    for (int i=0; i<self.sumShopingPace.count; i++) {
        int j, k;
        if (i==0) {
            j=0;
            k=2;
        }else
        {
            j=2;
            k=1;
        }
        UIButton *downButton;
        if (i==0) {
            downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        }else
        {
            downButton = [UIButton buttonWithType:UIButtonTypeSystem];
        }
        //设置价格的占屏幕的2/3， 去结算按钮占1/3
        downButton.frame = CGRectMake(self.view.frame.size.width/(float)(self.sumShopingPace.count+1) *j, 0, self.view.frame.size.width/(float)(self.sumShopingPace.count+1)*k, SettlementHeight);
        [downButton setTitle:self.sumShopingPace[i] forState:UIControlStateNormal];
        downButton.titleLabel.font = [UIFont systemFontOfSize:20];
        downButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        if (i==0) {
            downButton.backgroundColor = [UIColor blackColor];
            downButton.tag = 56567;
            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setLeftButtonText) userInfo:nil repeats:YES];
        }else
        {
            [downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            downButton.backgroundColor = [UIColor redColor];
            [downButton addTarget:self action:@selector(shoppingBuy) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.bgSortView addSubview:downButton];
    }
    [self.view addSubview:self.bgSortView];
}
#pragma mark - 购买商品按钮页面跳转
-(void)shoppingBuy
{
    settlementViewController *settlement = [[settlementViewController alloc] init];
    settlement.title = @"核对购物信息";
    //提取需要购买的物品
    NSString *strNew=nil;
    NSString *strOld=nil;
    for (int i=0; i<self.dataArray.count; i++) {
        shopingCarModel *shoppingCar = self.dataArray[i];
        strNew = [NSString stringWithFormat:@"%ld|%ld",(long)shoppingCar.cart_id, (long)[shoppingCar.goods_num integerValue]];
        if (strOld==nil) {
            strOld = strNew;
        }else
        {
            strOld = [NSString stringWithFormat:@"%@,%@", strOld, strNew];
        }
    }
    settlement.shoppingCarGoodsID = strOld;
    [self.navigationController pushViewController:settlement animated:YES];
}
#pragma mark - 计算商品的价格
-(void)setLeftButtonText
{
    float sumPace=0;
    for (UIButton *but in [self.bgSortView subviews]) {
        if (but.tag==56567 && self.dataArray.count>0) {
            for (int i=0; i<self.dataArray.count; i++) {
                shopingCarModel *shoping = self.dataArray[i];
                sumPace = sumPace+[shoping.goods_price integerValue]*[shoping.goods_num integerValue];
            }
            [but setTitle:[NSString stringWithFormat:@"总计:￥%.2f元", sumPace] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 视图离开的时候请求保存购买数量
-(void)viewWillDisappear:(BOOL)animated
{
    for (int i=0; i<self.dataArray.count; i++) {
        [self postChangeShopingCar:i];
    }
}
//修改购物车商品的数量
-(void)postChangeShopingCar:(int)number{
    
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
        shopingCarModel *shopping = self.dataArray[number];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *signInAddShoppingCar =
        [NSDictionary dictionaryWithObjectsAndKeys:
         signIn.key, @"key",
         [NSString stringWithFormat:@"%ld", (long)shopping.cart_id], @"cart_id",
         [NSString stringWithFormat:@"%ld", (long)[shopping.goods_num integerValue]], @"quantity",
         nil];
        [manager POST:changShopping parameters:signInAddShoppingCar success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dict);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }else
    {
        if (self.errorNetWork==nil) {
            self.errorNetWork = [loadingImageView setNetWorkRefreshError:self.view.frame viewString:@"请登录"];
            [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
            [self.view addSubview:self.errorNetWork];
        }
    }
}

-(void)setStoplabel
{
    [self.errorNetWork removeFromSuperview];
    self.errorNetWork = nil;
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
