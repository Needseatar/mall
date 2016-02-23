//
//  settlementViewController.m
//  mall
//
//  Created by Mihua on 13/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "settlementViewController.h"

#define sectionHeight 45 //每一个品牌的组头的高度
#define sectionFootHeight 90//每一个品牌的组尾高度

@interface settlementViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) storeCartModel *storeData;
@property (retain, nonatomic) UITableView    *tabelview;
@property (retain, nonatomic) UIView         *bgPayView; //点击支付方式的背景遮盖
@property (retain, nonatomic) NSMutableArray *payMethodArray; //保存了用户总共有的支付方式的字符串
@property (assign, nonatomic) NSInteger      pageOfPayMethod; //保存了用户选择的支付payMethodArray字符串里面的支付方式

@end

@implementation settlementViewController


#pragma mark - 设置按钮显示 返回
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]]; //设置返回按钮颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    
    self.tabBarController.tabBar.hidden = YES; //设置标签栏不隐藏
    
    if ([self.storeData isKindOfClass:[storeCartModel class]]) { //如果是上
        [self.tabelview reloadData];
    }
}
#pragma mark - 进入视图
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestShoppingCartFister];
    
    [self setTabelView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - 请求购买第一步
-(void)requestShoppingCartFister{
    
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *signInAddShoppingCar =
        [NSDictionary dictionaryWithObjectsAndKeys:
         signIn.key, @"key",
         self.shoppingCarGoodsID, @"cart_id",
         [NSString stringWithFormat:@"1"], @"ifcart",
         nil];
        NSLog(@"%@", signInAddShoppingCar);
        [manager POST:ShoppingCartFistBuy parameters:signInAddShoppingCar success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"JSON: %@", dict);
            self.storeData = [storeCartModel setValueWithDictionary:dict];
            
            //初始化用户的支付方式，是否支持货到付款
            if ([self.storeData.ifshow_offpay isKindOfClass:[NSString class]]) {
                
                if ([self.storeData.ifshow_offpay isEqualToString:@"true"]) {
                    self.payMethodArray = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"线上支付"], [NSString stringWithFormat:@"货到付款"], nil];
                }else
                {
                    self.payMethodArray = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"线上支付"], nil];
                }
            }else
            {
                self.payMethodArray = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"线上支付"], nil];
            }
            //初始化 用户的支付方式
            self.pageOfPayMethod = 0;
            
            [self.tabelview reloadData];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"Error: %@", error);
        }];
    }else //没有令牌，也就是没有登录
    {
        ;
    }
}

#pragma mark - 加载tabel
-(void)setTabelView
{
    self.tabelview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+TabBar) style:UITableViewStyleGrouped];
    [self.tabelview setBackgroundColor:[UIColor whiteColor]];
    [self.tabelview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tabelview.delegate = self;
    self.tabelview.dataSource = self;
    //self.tabelview.hidden = YES;
    [self.view addSubview:self.tabelview];
    
    //接收cell里面实行页面跳转
    NSNotificationCenter * nc1 = [NSNotificationCenter defaultCenter];
    [nc1 addObserver:self selector:@selector(inCellAddressSkip:) name:@"InFourViewControlSkip" object:nil];
}
#pragma mark -  界面跳转
-(void)inCellAddressSkip:(NSNotification *)notification
{
    NSString *str = [notification object];
    if ([str isEqualToString:@"AddressSkip"]) { //地址设置跳转
        setAddressViewController *addressViewControl = [[setAddressViewController alloc] init];
        addressViewControl.storeData = self.storeData;
        [self.navigationController pushViewController:addressViewControl animated:YES];
    }else if ([str isEqualToString:@"SetpPayMethodView"]) //支付方式设置
    {
        self.bgPayView = [[UIView alloc] initWithFrame:self.view.frame];
        self.bgPayView.backgroundColor = [UIColor blackColor];
        self.bgPayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.bgPayView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTapAction)];//加载点击动作
        [self.bgPayView addGestureRecognizer:tapAction];
        [self.view addSubview:self.bgPayView];
        
        UIView *payMethod;
        if (self.payMethodArray.count==2) { //支持货到付款
            payMethod = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-240/2.0, self.view.frame.size.height/2.0-180/2.0, 240, 180)];
            payMethod.backgroundColor = [UIColor whiteColor];
            [self.bgPayView addSubview:payMethod];
        }else
        {
            payMethod = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-240/2.0, self.view.frame.size.height/2.0-120/2.0, 240, 120)];
            payMethod.backgroundColor = [UIColor whiteColor];
            [self.bgPayView addSubview:payMethod];
        }
        
        //设置支付方式视图
        CGRect fram = payMethod.frame;
        NSMutableArray *mArray = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"支付方式"], nil];
        for (int i=0; i<self.payMethodArray.count; i++) {
            [mArray addObject:self.payMethodArray[i]];
        }
        //创建控件
        for (int i=0; i<mArray.count; i++) {
            UILabel *PayTitleMethod = [[UILabel alloc] initWithFrame:CGRectMake(0, i*fram.size.height/(float)mArray.count, fram.size.width, fram.size.height/(float)mArray.count-1)];
            PayTitleMethod.tag = 200+i;
            PayTitleMethod.text = mArray[i];
            if (i==0) {
                PayTitleMethod.textColor = [UIColor colorWithRed:36/255.0f green:158/255.0f blue:246/255.0f alpha:1];
                PayTitleMethod.backgroundColor = [UIColor whiteColor];
                
                //划线
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, i*fram.size.height/(float)mArray.count +fram.size.height/(float)mArray.count-1, fram.size.width, 1)];
                line.backgroundColor = [UIColor colorWithRed:36/255.0f green:158/255.0f blue:246/255.0f alpha:1];
                [payMethod addSubview:line];
            }else
            {
                PayTitleMethod.textColor = [UIColor blackColor];
                PayTitleMethod.backgroundColor = [UIColor whiteColor];
                
                //划线
                if (i!=mArray.count-1) {
                    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, i*fram.size.height/(float)mArray.count +fram.size.height/(float)mArray.count-1, fram.size.width, 1)];
                    line.backgroundColor = [UIColor blackColor];
                    [payMethod addSubview:line];
                }
            }
            PayTitleMethod.userInteractionEnabled = YES;
            UITapGestureRecognizer *PayTitleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PayTitleTapAction:)];//加载点击动作
            [PayTitleMethod addGestureRecognizer:PayTitleTap];
            
            [payMethod addSubview:PayTitleMethod];
        }
        
        
        [self.tabelview reloadData];
    }else if ([str isEqualToString:@"invoiceInformationSkip"]) //发票信息设置跳转
    {
        setVoiceInformationViewController *voiceViewControl = [[setVoiceInformationViewController alloc] init];
        voiceViewControl.storeData = self.storeData;
        [self.navigationController pushViewController:voiceViewControl animated:YES];
    }else if ([str isEqualToString:@"OrderPushSkip"]) //提交订单
    {
        [self requestShoppingCartSecond]; //购买第二步
    }
}
#pragma mark - 提交订单
-(void)requestShoppingCartSecond
{
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *signInAddShoppingCar =
        [NSDictionary dictionaryWithObjectsAndKeys:
         signIn.key, @"key",
         @"1", @"ifcart",
         @"22", @"cart_id",
         nil];
        NSLog(@"%@", signInAddShoppingCar);
        [manager POST:shoppingCartSecondBuy parameters:signInAddShoppingCar success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"JSON: %@", dict);
            
            submitOrderViewController *submitOrdre = [[submitOrderViewController alloc] init];
            [self.navigationController pushViewController:submitOrdre animated:YES];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"Error: %@", error);
        }];
    }else //没有令牌，也就是没有登录
    {
        ;
    }

}
//释放视图
-(void)bgViewTapAction
{
    [self.bgPayView removeFromSuperview];
}
//选择支付方式
-(void)PayTitleTapAction:(UITapGestureRecognizer *)action
{
    if (action.view.tag-200!=0) {
        self.pageOfPayMethod = action.view.tag-200-1;
        [self.bgPayView removeFromSuperview];
        [self.tabelview reloadData];
    }
}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0 || section==1 || section==2 || section==4+self.storeData.store_cart_list.count-1) {
        return 1;
    }
    storeCartInformaton *goodList = self.storeData.store_cart_list[section-3];
    return goodList.goods_list.count;
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4+self.storeData.store_cart_list.count;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) { //收件人
        static NSString * cellId = @"cell";
        settlementAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[settlementAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [cell setPeopleInformation:self.storeData.address_info];
        
        return cell;
    }else if (indexPath.section == 1) //支付方式
    {
        static NSString * cellId = @"cell1";
        PaymentMethodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[PaymentMethodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [cell setPeopleInformation:self.storeData payMethodString:self.payMethodArray[self.pageOfPayMethod]];
        
        return cell;
    }else if (indexPath.section == 2)  //订单明细
    {
        static NSString * cellId = @"cell2";
        settlementOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[settlementOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return cell;
    }else if (indexPath.section==4+self.storeData.store_cart_list.count-1) //最后的提交订单cell
    {
        static NSString * cellId = @"cell3";
        downSettlementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[downSettlementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        //计算总的价格
        float sumPace=0.0;;
        for (int i=0; i<self.storeData.store_cart_list.count; i++) {
            storeCartInformaton *goodList = self.storeData.store_cart_list[i];
            sumPace = [goodList.store_goods_total floatValue]+sumPace;
        }
        [cell setGoodsPace:sumPace];
        
        return cell;
    }else  //商品列表
    {
        static NSString * cellId = @"cell4";
        settlementShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[settlementShoppingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        NSArray *goodsArray = [self.storeData.store_cart_list[indexPath.section-3] goods_list];
        [cell setGoodsImageTitle:goodsArray[indexPath.row]];
        
        return cell;
    }
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return orderAddressCellHeight;
    }else if (indexPath.section==1)
    {
        return payMethodCellHeight;
    }else if (indexPath.section==2) {
        return orderInformationHeight;
    }
    return orderGoodsCellHeight;
}
//返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0 || section==1 || section==2) {
        return 15;
    }else if (section==4+self.storeData.store_cart_list.count-1)
    {
        return 0.01;
    }else
    {
        return sectionHeight;
    }
}
//返回组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section>=3 && section!=4+self.storeData.store_cart_list.count-1) {
        return sectionFootHeight;
    }
    return 0.01;
}
#pragma mark - 返回组头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section >=3 && section!=4+self.storeData.store_cart_list.count-1) {
        UIView *headerview = [[UIView alloc] init];
        
        //把image去掉波浪线
        UIImage *img = [UIImage imageNamed:@"shopping_checkout_body_bg.png"];
        CGSize sz = [img size];
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width, sz.height-10), NO, 0);
        [img drawAtPoint:CGPointMake(0, -10)];
        UIImage* BGImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext(); //关闭上下文
        //背景视图
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(orderRightLeftWidth, 0, self.view.frame.size.width-2*orderRightLeftWidth, sectionHeight)];
        [bgImageView setImage:BGImg];
        bgImageView.contentMode = UIViewContentModeScaleToFill;
        [headerview addSubview:bgImageView];
        
        //上边的分隔线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, 0, bgImageView.frame.size.width-2*orderTextwidth, 1)];
        line.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
        [bgImageView addSubview:line];
        
        //店铺名字
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderTextwidth, 1, self.view.frame.size.width-2*(orderRightLeftWidth+orderTextwidth), sectionHeight-1)];
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.backgroundColor = greenColorDebug;
        storeCartInformaton *goodList = self.storeData.store_cart_list[section-3];
        titleLabel.text = goodList.store_name;
        [bgImageView addSubview:titleLabel];
        
        return headerview;
    }
    return nil;
}
#pragma mark - 返回组尾视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section >=3 && section!=4+self.storeData.store_cart_list.count-1)
    {
        storeCartInformaton *goodList = self.storeData.store_cart_list[section-3];
        
        UIView *footerview = [[UIView alloc] init];
        
        //把image去掉波浪线
        UIImage *img = [UIImage imageNamed:@"shopping_checkout_body_bg.png"];
        CGSize sz = [img size];
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width, sz.height-10), NO, 0);
        [img drawAtPoint:CGPointMake(0, -10)];
        UIImage* BGImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext(); //关闭上下文
        //背景视图
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(orderRightLeftWidth, 0, self.view.frame.size.width-2*orderRightLeftWidth, sectionFootHeight)];
        [bgImageView setImage:BGImg];
        bgImageView.contentMode = UIViewContentModeScaleToFill;
        [footerview addSubview:bgImageView];
        
        //运输费
        UILabel *transportLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderTextwidth, 15, self.view.frame.size.width-2*(orderRightLeftWidth+orderTextwidth), 25)];
        transportLabel.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1];
        transportLabel.text = @"运输费:";
        [bgImageView addSubview:transportLabel];
        
        //运输费价格
        UILabel *transportPaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderTextwidth+60, 15, transportLabel.frame.size.width-60, transportLabel.frame.size.height)];
        transportPaceLabel.backgroundColor = [UIColor clearColor];
        transportPaceLabel.textColor = [UIColor redColor];
        //计算本店运费
        float SUMpace =0;
        for (int i=0; i<goodList.goods_list.count; i++) {
            SUMpace = SUMpace+[[goodList.goods_list[i] goods_freight] floatValue];
        }
        transportPaceLabel.text = [NSString stringWithFormat:@"￥%.2f", SUMpace];
        transportPaceLabel.textAlignment = NSTextAlignmentRight;
        [bgImageView addSubview:transportPaceLabel];
        
        
        //本店合计
        UILabel *SUMLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderTextwidth, transportLabel.frame.size.height+transportLabel.frame.origin.y+10, self.view.frame.size.width-2*(orderRightLeftWidth+orderTextwidth), 25)];
        SUMLabel.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1];
        SUMLabel.text = @"本店合计:";
        [bgImageView addSubview:SUMLabel];
        
        //本店小记价格
        UILabel *SUMPaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderTextwidth+75, transportLabel.frame.size.height+transportLabel.frame.origin.y+10, SUMLabel.frame.size.width-75, SUMLabel.frame.size.height)];
        SUMPaceLabel.backgroundColor = [UIColor clearColor];
        SUMPaceLabel.textColor = [UIColor redColor];
        SUMPaceLabel.text = [NSString stringWithFormat:@"￥%@", goodList.store_goods_total];
        SUMPaceLabel.textAlignment = NSTextAlignmentRight;
        [bgImageView addSubview:SUMPaceLabel];
        
        
        return footerview;
    }
    
    return nil;
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
