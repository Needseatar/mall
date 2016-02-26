//
//  submitOrderViewController.m
//  mall
//
//  Created by Mihua on 23/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "submitOrderViewController.h"

@interface submitOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) int  page;
@property (assign, nonatomic) int  curpage;

@property (retain, nonatomic) UITableView *orderTabelView;
@property (retain, nonatomic) myOrderModelList *data;
@property (retain, nonatomic) UIButton         *payOrder;

@end

@implementation submitOrderViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitializedData]; //初始化数据
    
    [self setTabelView]; //设置tabel
    
    [self requestMyOrder]; //请求数据
}
#pragma mark - 初始化数据
-(void)InitializedData
{
    self.title = @"订单";
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 10;
    self.curpage = 1;
}

#pragma mark - 请求数据
-(void)requestMyOrder
{
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *signInAddShoppingCar =
        [NSDictionary dictionaryWithObjectsAndKeys:
         signIn.key, @"key", nil];
        NSString *myOrderListURL = MyOrderList;
        myOrderListURL = [NSString stringWithFormat:@"%@&page=%d&curpage=%d", myOrderListURL, self.page, self.curpage];
        [manager POST:myOrderListURL parameters:signInAddShoppingCar success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"JSON: %@", dict);
            
            if ([self.data isKindOfClass:[myOrderModelList class]] && self.curpage!=1) {
                myOrderModelList *newData = [myOrderModelList setValueWithDictionary:dict];
                for (int i=0; i<newData.order_group_list.count; i++) {
                    [self.data.order_group_list addObject:newData.order_group_list[i]];
                }
            }else
            {
                self.data = [myOrderModelList setValueWithDictionary:dict];
            }
            [self.orderTabelView.mj_header endRefreshing];
            [self.orderTabelView.mj_footer endRefreshing];
            [self.orderTabelView reloadData];
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            
            NSLog(@"Error: %@", error);
        }];
    }else //没有令牌，也就是没有登录
    {
        ;
    }
}

#pragma mark - 设置tabel
-(void)setTabelView
{
    self.orderTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+TabBar) style:UITableViewStyleGrouped];
    self.orderTabelView.delegate = self;
    self.orderTabelView.dataSource = self;
    [self.view addSubview:self.orderTabelView];
    
    //加载下拉菜单
    self.orderTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //初始化数据
        self.page = 10;  //设置请求数量
        self.curpage = 1; //设置当前页码
        //进入刷新状态后会自动调用这个block
        [self requestMyOrder];
    }];
    
    //加载上拉菜单
    self.orderTabelView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        //初始化数据
        self.page = 10;  //设置请求数量
        if ([self.data hasmore]) {
            self.curpage++; //设置当前页码
        }
        //进入刷新状态后会自动调用这个block
        [self requestMyOrder];
    }];
}
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.data.order_group_list[section] packArray] count];
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.data.order_group_list count];
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = [self.data.order_group_list[indexPath.section] packArray];
    
    if ([array[indexPath.row] isKindOfClass:[dataOrderListModel class]]) {
        static NSString * cellId = @"cell1";
        submitOrderHeadTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[submitOrderHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色
        [cell setStrigLabel:array[indexPath.row]];
        
        return cell;
    }else if ([array[indexPath.row] isKindOfClass:[extendOrderGoods class]]){
        static NSString * cellId = @"cell2";
        shoppingOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[shoppingOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色
        
        [cell setImageAndText:array[indexPath.row]];
        
        return cell;
    }else
    {
        static NSString * cellId = @"cell3";
        submitOrderFootTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[submitOrderFootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色
        NSDictionary *arrayDic = array[indexPath.row];
        [cell setStrigLabel:arrayDic[@"foot"] cellOrderID:^void(NSString *orderID){
            [self cancelStoreOrder:orderID];
        }];
        
        return cell;
    }
}
//跳转到介绍
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ;
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [self.data.order_group_list[indexPath.section] packArray];
    if ([array[indexPath.row] isKindOfClass:[dataOrderListModel class]]) {
        return 70;
    }else if ([array[indexPath.row] isKindOfClass:[extendOrderGoods class]]){
        return 150;
    }else
    {
        NSDictionary *arrayDic = array[indexPath.row];
        if ([[arrayDic[@"foot"] if_cancel] integerValue]) {
            return 150;
        }else
        {
            return 110;
        }
    }
}
//返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }else
    {
        return 60;
    }
}
//返回组头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] init];
    int headHeight = 60;
    if (section==0) {
        headHeight = 30;
    }else
    {
        headHeight = 60;
    }
    bgView.frame = CGRectMake(0, 0, self.view.frame.size.width, headHeight);
    bgView.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
    
    UILabel *loadingOrderlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headHeight-30, self.view.frame.size.width, 30)];
    if ([[self.data.order_group_list[section] pay_amount] integerValue] <= 0) {
        loadingOrderlabel.backgroundColor = [UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1];
    }else
    {
        loadingOrderlabel.backgroundColor = [UIColor colorWithRed:0/255.0f green:128/255.0f blue:0/255.0f alpha:1];
    }
    loadingOrderlabel.textColor = [UIColor whiteColor];
    loadingOrderlabel.text = [NSString stringWithFormat:@"下单时间:%@", [self setNumberToTime:[self.data.order_group_list[section] add_time]]];
    [bgView addSubview:loadingOrderlabel];
    
    return bgView;
}
//返回组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSString *paceString = [self.data.order_group_list[section] pay_amount];
    if ([paceString integerValue]>0) {
        return 60;
    }
    return 0.01;
}
//组尾视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString *paceString = [self.data.order_group_list[section] pay_amount];
    if ([paceString integerValue]>0) {
        double pace = [paceString doubleValue];
        paceString = [NSString stringWithFormat:@"订单支付(%.2f)元", pace];
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = blueColorDebug;
        
        self.payOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        self.payOrder.frame = CGRectMake(10, 10, self.view.frame.size.width-2*10, 40);
        [self.payOrder setBackgroundColor:[UIColor redColor]];
        [self.payOrder setTitle:paceString forState:UIControlStateNormal];
        [self.payOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.payOrder addTarget:self action:@selector(addOrderSever) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:self.payOrder];
        
        return bgView;
    }
    return nil;
}

#pragma mark - 提交订单按钮
-(void)addOrderSever
{
    publicTabelViewController *PTVC = [[publicTabelViewController alloc] init];
    [PTVC screenshot];
    [self presentViewController:PTVC animated:NO completion:nil];
}

#pragma mark - 时间戳转换成时间
-(NSString *)setNumberToTime:(NSString *)str
{
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    NSLog(@"%@", currentDateStr);
    return currentDateStr;
}

#pragma mark - 取消店铺订单
-(void)cancelStoreOrder:(NSString *)orderID
{
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *cancelStoreOrder=
        [NSDictionary dictionaryWithObjectsAndKeys:
         signIn.key, @"key",
         orderID, @"order_id", nil];
        NSLog(@"%@", cancelStoreOrder);
        [manager POST:cancelOrderURL parameters:cancelStoreOrder success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"JSON: %@", dict);
            if ([dict[@"datas"] integerValue] == 1) {
                [self requestMyOrder]; //请求数据刷新页面
            }
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            
            NSLog(@"Error: %@", error);
        }];
    }else //没有令牌，也就是没有登录
    {
        ;
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
