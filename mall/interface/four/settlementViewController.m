//
//  settlementViewController.m
//  mall
//
//  Created by Mihua on 13/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "settlementViewController.h"

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
    self.tabelview.delegate = self;
    self.tabelview.dataSource = self;
    //self.tabelview.hidden = YES;
    [self.view addSubview:self.tabelview];
}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.layer.borderWidth=1;
    if (indexPath.row % 2)
    {
        [cell setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:1 alpha:1]];
    }else {
        [cell setBackgroundColor:[UIColor orangeColor]];
    }
    
    return cell;
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0 || section==1 || section==2) {
        return 0.1;
    }else
    {
        return 0.1;
    }
}
//返回组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
////返回组头视图
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerview = [[UIView alloc] init];
//    headerview.backgroundColor = [UIColor whiteColor];
//    return headerview;
//}
////返回组尾视图
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footerview = [[UIView alloc] init];
//    footerview.backgroundColor = [UIColor whiteColor];
//    return footerview;
//}

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
