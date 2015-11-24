//
//  fiveViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//

#import "fiveViewController.h"

@interface fiveViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (retain, nonatomic) UITableView    *tableView;
@property (strong, nonatomic) NSMutableArray *mArray;

@property (strong, nonatomic) UIView         *bgSignInview;

@end

@implementation fiveViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES; //隐藏导航控制器
    
    self.tabBarController.tabBar.hidden = NO;  //便签控制器不隐藏
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self setTabelView];  //设置tabel
    
    [self setNavigationController];  //设置标签栏隐藏
}

#pragma mark -  初始化参数
-(void)setData
{
    NSArray *array1 = @[@"个人账户"];
    NSArray *array2 = @[@"我的订单", @"虚拟订单"];
    NSArray *array3 = @[@"我的代金劵", @"收藏的店铺"];
    NSArray *array4 = @[@"系统消息", @"版本更新"];
    NSArray *array5 = @[@"建议反馈", @"关于"];
    
    _mArray = [[NSMutableArray alloc] init];
    [_mArray addObject:array1];
    [_mArray addObject:array2];
    [_mArray addObject:array3];
    [_mArray addObject:array4];
    [_mArray addObject:array5];
}

#pragma mark -  设置导航栏的颜色
-(void)setNavigationController
{
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]]; //设置返回按钮颜色
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]]; //设置导航栏颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]]; //设置标题颜色
}

#pragma mark - 设置TabelView界面
-(void)setTabelView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMakeEx(0, -20, 340, 600) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

//返回表格的行数的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [_mArray[section] count];
}
//返回表格的组数的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _mArray.count;
}
//获取到表格有多少个分组，每个分组有多少行数据以后，就调用该方法，去返回表格的每一行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //用户登陆界面
    if (indexPath.section == 0) {
        static NSString * cellId1 = @"cell1";
        fiveViewUserTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellId1];
        if(cell1 == nil){
            cell1 = [[fiveViewUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
            [cell1 comeBackActionString:^void(NSString *string){ //返回按钮按下后执行的字符串
                NSArray *backStringArray = @[@"registeredAction", @"signInAction", @"userAction", @"attentionAction", @"browseAction", @"addressAction"];
                int selectFunction = 100;
                for (int i=0; i<backStringArray.count; i++) {
                    if ([string isEqualToString:backStringArray[i]]) {
                        selectFunction = i;
                        break;
                    }
                }
                switch (selectFunction) {
                    case 0:
                        [self registeredAction];
                        break;
                    case 1:
                        [self signInAction];
                        break;
                    case 2:
                        [self userAction];
                        break;
                    case 3:
                        [self attentionAction];
                        break;
                    case 4:
                        [self browseAction];
                        break;
                    case 5:
                        [self addressAction];
                        break;
                    case 100:
                        NSLog(@"the string is null");
                        break;
                        
                    default:
                        break;
                }
            }];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell1;
        
    }else // 其它信息
    {
        static NSString * cellId = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //设置右边箭头
        cell.selectionStyle = UITableViewCellSelectionStyleNone; // 设置选中没有颜色
        
        NSArray *array = _mArray[indexPath.section];
        
        cell.textLabel.text = array[indexPath.row];
        
        return cell;
    }
    
}
//跳转到介绍
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) { //用户的那个歌表格设置没有进入界面
        
    }else if (indexPath.section == 4 && indexPath.row == 1) //进入关于的界面
    {
        fiveAboutViewController *FAV = [[fiveAboutViewController alloc] init];
        [self.navigationController pushViewController:FAV animated:YES];
    }
    
}
//返回行高的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return heightEx(130);
    }else
    {
        return widthEx(35);
    }
}
//返回组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//返回组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else
    {
        return heightEx(10);
    }
}


#pragma mark -  第一组里面按钮的点击动作
//登陆动作
-(void)signInAction
{
    //背景遮盖
    self.bgSignInview = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 0, 340, 600)];
    self.bgSignInview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5]; //设置的alpha只在子视图中没有继承
    self.tabBarController.tabBar.hidden = YES;
    UITapGestureRecognizer * bgSignInTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgSignInTapAction)];//加载点击动作
    [self.bgSignInview addGestureRecognizer:bgSignInTap];
    self.bgSignInview.userInteractionEnabled = YES;
    [self.view addSubview:self.bgSignInview];
    
    //视图背景
    UIView *childBgSingnInView = [[UIView alloc] initWithFrame:CGRectMakeEx(50, 180, 220, 170)];
    childBgSingnInView.backgroundColor = [UIColor colorWithRed:70.0f/255.0f green:170.0f/255.0f blue:220.0f/255.0f alpha:1];
    childBgSingnInView.alpha = 1;
    childBgSingnInView.layer.cornerRadius = 20; //设置layer的圆角
    childBgSingnInView.layer.masksToBounds = YES; // 超出部分覆盖
    childBgSingnInView.layer.borderWidth = 3;//边框宽度
    childBgSingnInView.layer.borderColor = [[UIColor whiteColor] CGColor];//边框颜色
    UITapGestureRecognizer *childBgSignInTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(childBgSignInAction)];//加载点击动作
    [childBgSingnInView addGestureRecognizer:childBgSignInTap];
    childBgSingnInView.userInteractionEnabled = YES;
    [self.bgSignInview addSubview:childBgSingnInView];
    
    //用户账号
    UITextField *userAccoutTextFild = [[UITextField alloc] initWithFrame:CGRectMakeEx(10, 30, 200, 30)];
    userAccoutTextFild.borderStyle = UITextBorderStyleNone;
    userAccoutTextFild.placeholder = @"手机号／泰润商城账号";
    userAccoutTextFild.backgroundColor = [UIColor whiteColor];
    UIImageView * userAccoutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    userAccoutImageView.image = [UIImage imageNamed:@"icon_login_user_account.png"];
    userAccoutTextFild.leftView  = userAccoutImageView; //设置左边小图标
    userAccoutTextFild.leftViewMode = UITextFieldViewModeAlways;//设置小图标显示的模式
    userAccoutTextFild.tag = 10;
    userAccoutTextFild.delegate = self;
    [userAccoutTextFild becomeFirstResponder];
    [childBgSingnInView addSubview:userAccoutTextFild];
    
    //用户密码
    UITextField *userPasswordTextFild = [[UITextField alloc] initWithFrame:CGRectMakeEx(10, 60, 200, 30)];
    userPasswordTextFild.borderStyle = UITextBorderStyleNone;
    userPasswordTextFild.placeholder = @"密码";
    userPasswordTextFild.backgroundColor = [UIColor whiteColor];
    UIImageView * userPasswordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    userPasswordImageView.image = [UIImage imageNamed:@"icon_login_password.png"];
    userPasswordTextFild.leftView  = userPasswordImageView; //设置左边小图标
    userPasswordTextFild.leftViewMode = UITextFieldViewModeAlways;//设置小图标显示的模式
    userPasswordTextFild.secureTextEntry = YES; //输入的字符不显示出来
    userPasswordTextFild.autocapitalizationType = UITextAutocapitalizationTypeNone;  //设置键盘不大写
    userPasswordTextFild.autocorrectionType = UITextAutocorrectionTypeNo; //设置密码输入键盘
    userPasswordTextFild.tag = 11;
    userPasswordTextFild.delegate = self;
    [childBgSingnInView addSubview:userPasswordTextFild];
    
    //注册按钮
    UIButton *registeredButton = [UIButton buttonWithType:UIButtonTypeSystem];
    registeredButton.frame = CGRectMakeEx(10, 100, 70, 30);
    registeredButton.backgroundColor = [UIColor whiteColor];
    [registeredButton setTitle:@"注册" forState:UIControlStateNormal];
    [registeredButton setTitleColor:[UIColor colorWithRed:70.0f/255.0f green:170.0f/255.0f blue:220.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [registeredButton addTarget:self action:@selector(registered) forControlEvents:UIControlEventTouchUpInside];
    [childBgSingnInView addSubview:registeredButton];
    
    //登陆按钮
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeSystem];
    signInButton.frame = CGRectMakeEx(140, 100, 70, 30);
    signInButton.backgroundColor = [UIColor whiteColor];
    [signInButton setTitle:@"登陆" forState:UIControlStateNormal];
    [signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signInButton setBackgroundColor:[UIColor colorWithRed:102.0f/255.0f green:204.0f/255.0f blue:34.0f/255.0f alpha:1]];
    [signInButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    [childBgSingnInView addSubview:signInButton];
}
//头像点击动作
-(void)userAction
{
    ;
}
//关注的商品点击动作
-(void)attentionAction
{
    ;
}
//浏览记录点击动作
-(void)browseAction
{
    ;
}
//地址点击动作
-(void)addressAction
{
    ;
}
//视图动作
-(void)bgSignInTapAction
{
    [self.bgSignInview removeFromSuperview];
    self.tabBarController.tabBar.hidden = NO;
}
//子视图背景动作
-(void)childBgSignInAction
{
    UITextField * userAccoutTextFild = (UITextField *)[self.bgSignInview viewWithTag:10];
    [userAccoutTextFild resignFirstResponder];
    UITextField * userPasswordTextFild = (UITextField *)[self.bgSignInview viewWithTag:11];
    [userPasswordTextFild resignFirstResponder];
}
#pragma mark - textfield按return时代理
//当用户点击return键的时候执行该方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITextField * userAccoutTextFild = (UITextField *)[self.bgSignInview viewWithTag:10];
    UITextField * userPasswordTextFild = (UITextField *)[self.bgSignInview viewWithTag:11];
    if (textField == userAccoutTextFild) {
        [textField resignFirstResponder];
        [userPasswordTextFild becomeFirstResponder];
    }else
    {
        [userAccoutTextFild resignFirstResponder];
        [userPasswordTextFild resignFirstResponder];
        [self signIn];
    }
    return YES;
}
//登陆
-(void)signIn
{
    UITextField * userAccoutTextFild = (UITextField *)[self.bgSignInview viewWithTag:10];
    UITextField * userPasswordTextFild = (UITextField *)[self.bgSignInview viewWithTag:11];
    NSLog(@"%@", userAccoutTextFild.text);
    NSLog(@"%@", userPasswordTextFild.text);
}
//删除并退出登录界面，然后进入注册界面
-(void)registered
{
    [self.bgSignInview removeFromSuperview];
    self.tabBarController.tabBar.hidden = NO;
    [self registeredAction];
}
//跳转到注册动作
-(void)registeredAction
{
    fiveRegisteredViewController * FRV = [[fiveRegisteredViewController alloc] init];
    [self.navigationController pushViewController:FRV animated:YES];
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
