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

@end

@implementation settlementViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]]; //设置返回按钮颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    [self requestShoppingCartFister];
}
#pragma mark - 进入视图
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
            
            NSLog(@"%@", self.storeData.freight_hash);
            
            addressInfo *dadf = self.storeData.address_info;
            NSLog(@"%@", dadf.area_info);
            
            ShoppingInvInfo *lll = self.storeData.inv_info;
            NSLog(@"%@", lll.inv_content);
            
            storeCartInformaton *lsd = self.storeData.store_cart_list[0];
            NSLog(@"%@", lsd.store_name);
            
            
            storeCartGoodsList *dsdl = lsd.goods_list[0];
            NSLog(@"%@", dsdl.goods_name);
            
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
    self.tabelview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [self.tabelview setBackgroundColor:[UIColor whiteColor]];
    [self.tabelview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tabelview.delegate = self;
    self.tabelview.dataSource = self;
    //self.tabelview.hidden = YES;
    [self.view addSubview:self.tabelview];
}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0 || section==1 || section==2) {
        return 1;
    }
    return 6;
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        static NSString * cellId = @"cell";
        settlementAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[settlementAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [cell setPeopleInformation:self.storeData.address_info];
        
        return cell;
    }else if (indexPath.section == 1)
    {
        static NSString * cellId = @"cell1";
        PaymentMethodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[PaymentMethodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return cell;
    }else if (indexPath.section == 2)
    {
        static NSString * cellId = @"cell2";
        settlementOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[settlementOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return cell;
    }else if (indexPath.section == 7)
    {
        static NSString * cellId = @"cell3";
        downSettlementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[downSettlementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return cell;
    }else if (indexPath.section >= 7)
    {
        static NSString * cellId = @"cell4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = @"";
        
        return cell;
    }else
    {
        static NSString * cellId = @"cell5";
        settlementShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[settlementShoppingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
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
    return 80;
}
//返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0 || section==1 || section==2) {
        return 15;
    }else
    {
        return sectionHeight;
    }
}
//返回组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section>=3) {
        return sectionFootHeight;
    }
    return 0.01;
}
//返回组头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section >=3) {
        UIView *headerview = [[UIView alloc] init];
        headerview.backgroundColor = [UIColor orangeColor];
        
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
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderTextwidth, 0, self.view.frame.size.width-2*(orderRightLeftWidth+orderTextwidth), sectionHeight)];
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.backgroundColor = [UIColor greenColor];
        titleLabel.text = @"我的最爱";
        [bgImageView addSubview:titleLabel];
        
        return headerview;
    }
    return nil;
}
//返回组尾视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section >=3)
    {
        UIView *footerview = [[UIView alloc] init];
        footerview.backgroundColor = [UIColor blueColor];
        
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
        transportPaceLabel.text = @"￥0.0";
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
        SUMPaceLabel.text = @"￥55.0";
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
