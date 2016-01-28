//
//  setAddressViewController.m
//  mall
//
//  Created by Mihua on 22/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "setAddressViewController.h"

#define bgAddAddressHeight 60

@interface setAddressViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) UITableView    *tabelview;
@property (retain, nonatomic) NSArray        *addressData;


@end

@implementation setAddressViewController

#pragma mark - 设置按钮显示 返回
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址管理";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestAddressList]; //请求地址列表
    
    [self setTabelView]; //设置tabel
    
    [self addAddressButton]; //添加地址按钮
}

#pragma mark - 请求地址列表
-(void)requestAddressList{
    
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *signInAddShoppingCar =
        [NSDictionary dictionaryWithObjectsAndKeys:
         signIn.key, @"key",nil];
        [manager POST:UserAddressList parameters:signInAddShoppingCar success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"JSON: %@", dict);
            
            self.addressData = [addressListModel setValueWithDictionary:dict];
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
    self.tabelview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+TabBar-bgAddAddressHeight) style:UITableViewStyleGrouped];
    [self.tabelview setBackgroundColor:[UIColor whiteColor]];
    //[self.tabelview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tabelview.delegate = self;
    self.tabelview.dataSource = self;
    //self.tabelview.hidden = YES;
    [self.view addSubview:self.tabelview];
    
}
#pragma mark - tabelView代理
//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressData.count;
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"cell";
    setAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[setAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell setlabelTitle:self.addressData[indexPath.row]];
    
    return cell;
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

//返回组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
//返回组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark - 编辑删除table
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark 在滑动手势删除某一行的时候，显示按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除");
        
    }];
    
    // 删除一个置顶按钮
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了编辑");
        
        
    }];
    editRowAction.backgroundColor = [UIColor orangeColor];
    
    // 将设置好的按钮放到数组中返回
    return @[deleteRowAction, editRowAction];
}


#pragma mark - 添加地址按钮
-(void)addAddressButton
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-bgAddAddressHeight, self.view.frame.size.width, bgAddAddressHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIButton *addressButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addressButton.frame = CGRectMake(5, 5, bgView.frame.size.width-2*5, bgView.frame.size.height-2*5);
    [addressButton setTitle:@"添加地址" forState:UIControlStateNormal];
    addressButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [addressButton setBackgroundColor:[UIColor redColor]];
    [addressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addressButton addTarget:self action:@selector(AddaddressAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:addressButton];
}
-(void)AddaddressAction
{
    addAddressViewController *addAddress = [[addAddressViewController alloc] init];
    [self.navigationController pushViewController:addAddress animated:YES];
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
