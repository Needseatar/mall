//
//  fiveViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//
/*
 * 1.第一组数据是在自定义cell里面进行加载的，并且cell里面的点击动作，会反传出字符串出来，根据反传出来的字符串可以执行相应的函数
 * 2.注册和登录，等待时候都加载了背景遮盖视图，然后会加载风火轮
 * 
 *
 */


#import "fiveViewController.h"

@interface fiveViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (retain, nonatomic) UITableView    *tableView;
@property (strong, nonatomic) NSMutableArray *mArray;

@property (retain, nonatomic) UIView          *bgSignInview;
@property (retain, nonatomic) UIView          *childBgSingnInView;
@property (retain, nonatomic) UIView          *bgSignInIndicatorView;
@property (retain, nonatomic) UIActivityIndicatorView * actv; //注销按钮背景视图

@property (retain, nonatomic) signInModel     *userToken;

@property (retain, nonatomic) UIView          *bgCancellation;

@property (retain, nonatomic) fiveMyMallmodel *myMall;

@property (retain, nonatomic) UILabel         *setLabel;

@end

@implementation fiveViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES; //隐藏导航控制器
    
    self.tabBarController.tabBar.hidden = NO;  //便签控制器不隐藏
    
    if (self.tableView != nil) {
        signInModel * SIModel = [signInModel initSingleCase];
        self.userToken = [signInModel sharedUserTokenInModel:SIModel]; //单例创建，要是有令牌，将直接登录
        if (self.userToken.key.length != 0) { //判断有没有令牌
            [self singnInBecomeUserData];
            [self.tableView reloadData];
        }
    }
    
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
    
    self.userToken = [signInModel initSetUser];
}

#pragma mark -  设置导航栏的颜色
-(void)setNavigationController
{
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]]; //设置返回按钮颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]]; //设置导航栏颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]]; //设置标题颜色
}

#pragma mark - 设置TabelView界面
-(void)setTabelView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMakeEx(0, -20, 320, 600) style:UITableViewStyleGrouped];
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
                        [self signInActionBG];
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
        
        [cell1 setButtonAndUser:self.userToken userMyMall:self.myMall];  //判断userToken有没有登录成功，成功救获取数据显示出来，并且取消释放登录界面
        
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
    if (indexPath.section == 0) { //用户的那个表格设置没有进入界面
        
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
    if (self.userToken.whetherSignIn == YES && section == _mArray.count-1) {
        return 50;
    }else
    {
        return 0.01;
    }
}
#pragma mark - 当用户获取道令牌登录的时候，返回尾端的注销按钮
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.userToken.whetherSignIn == YES && section == _mArray.count-1) {
        self.bgCancellation = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 0, 320, 50)];
        self.bgCancellation.backgroundColor = [UIColor clearColor];
        
        UIButton *CancellationButton = [UIButton buttonWithType:UIButtonTypeSystem];
        CancellationButton.frame = CGRectMakeEx(10, 20, 300, 25);
        [CancellationButton setTitle:@"注销" forState:UIControlStateNormal];
        [CancellationButton setBackgroundColor:[UIColor redColor]];
        [CancellationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [CancellationButton addTarget:self action:@selector(cancellationAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bgCancellation addSubview:CancellationButton];
        
        return self.bgCancellation;
    }else
    {
        return nil;
    }
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
#pragma mark - 注销登录
-(void)cancellationAction
{
    //请求注销
    AFHTTPRequestOperationManager *myManager = [AFHTTPRequestOperationManager manager];
    myManager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    NSDictionary *myMallParameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userToken.username, @"username", self.userToken.key, @"key", @"ios", @"client", nil];
    [myManager POST:Cancellation parameters:myMallParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"datas"] integerValue] == 1) {
            [self.actv stopAnimating];     //结束等待界面的动画
            [self.bgSignInview removeFromSuperview];
            signInModel * cancellationModel = [signInModel initSetUser];
            self.userToken = [signInModel sharedUserTokenInModel:cancellationModel]; //清空登录令牌
            [_tableView reloadData];
        }else
        {
            
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.childBgSingnInView.hidden = NO;
        [self.actv stopAnimating];     //结束等待界面的动画
        [self.actv removeFromSuperview];
    }];
    [self setSignInBGView]; //加载背景遮盖
    [self setIndicator];   //加载风火轮
}

#pragma mark - 设置登录背景
//登陆时候背景遮盖
-(void)signInActionBG
{
    //加载背景遮盖
    [self setSignInBGView];
    
    //加载登录界面
    [self signInAction];
    
}
-(void)setSignInBGView
{
    //背景遮盖
    self.bgSignInview = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 0, 340, 600)];
    self.bgSignInview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5]; //设置的alpha只在子视图中没有继承
    self.tabBarController.tabBar.hidden = YES;
    UITapGestureRecognizer * bgSignInTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgSignInTapAction)];//加载点击动作
    [self.bgSignInview addGestureRecognizer:bgSignInTap];
    self.bgSignInview.userInteractionEnabled = YES;
    [self.view addSubview:self.bgSignInview];
}
#pragma mark -  登录界面
-(void)signInAction
{
    //视图背景
    self.childBgSingnInView = [[UIView alloc] initWithFrame:CGRectMakeEx(50, 180, 220, 170)];
    self.childBgSingnInView.backgroundColor = [UIColor colorWithRed:70.0f/255.0f green:170.0f/255.0f blue:220.0f/255.0f alpha:1];
    self.childBgSingnInView.alpha = 1;
    self.childBgSingnInView.layer.cornerRadius = 20; //设置layer的圆角
    self.childBgSingnInView.layer.masksToBounds = YES; // 超出部分覆盖
    self.childBgSingnInView.layer.borderWidth = 3;//边框宽度
    self.childBgSingnInView.layer.borderColor = [[UIColor whiteColor] CGColor];//边框颜色
    UITapGestureRecognizer *childBgSignInTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(childBgSignInAction)];//加载点击动作
    [self.childBgSingnInView addGestureRecognizer:childBgSignInTap];
    self.childBgSingnInView.userInteractionEnabled = YES;
    [self.bgSignInview addSubview:self.childBgSingnInView];
    
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
    [self.childBgSingnInView addSubview:userAccoutTextFild];
    
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
    [self.childBgSingnInView addSubview:userPasswordTextFild];
    
    //注册按钮
    UIButton *registeredButton = [UIButton buttonWithType:UIButtonTypeSystem];
    registeredButton.frame = CGRectMakeEx(10, 100, 70, 30);
    registeredButton.backgroundColor = [UIColor whiteColor];
    [registeredButton setTitle:@"注册" forState:UIControlStateNormal];
    [registeredButton setTitleColor:[UIColor colorWithRed:70.0f/255.0f green:170.0f/255.0f blue:220.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [registeredButton addTarget:self action:@selector(registered) forControlEvents:UIControlEventTouchUpInside];
    [self.childBgSingnInView addSubview:registeredButton];
    
    //登陆按钮
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeSystem];
    signInButton.frame = CGRectMakeEx(140, 100, 70, 30);
    signInButton.backgroundColor = [UIColor whiteColor];
    [signInButton setTitle:@"登陆" forState:UIControlStateNormal];
    [signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signInButton setBackgroundColor:[UIColor colorWithRed:102.0f/255.0f green:204.0f/255.0f blue:34.0f/255.0f alpha:1]];
    [signInButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    [self.childBgSingnInView addSubview:signInButton];
}
#pragma mark - 头像点击动作
-(void)userAction
{
    ;
}
#pragma mark - 关注的商品点击动作
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
    if (self.actv.isAnimating == NO) { //风火轮没有的时候才加载点击动作
        [self.bgSignInview removeFromSuperview];
        self.tabBarController.tabBar.hidden = NO;
    }
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
#pragma mark - 登陆
-(void)signIn
{
    UITextField * userAccoutTextFild = (UITextField *)[self.bgSignInview viewWithTag:10];
    UITextField * userPasswordTextFild = (UITextField *)[self.bgSignInview viewWithTag:11];
    [userAccoutTextFild resignFirstResponder];
    [userPasswordTextFild resignFirstResponder]; //回收键盘
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    NSDictionary *signInParameters = [NSDictionary dictionaryWithObjectsAndKeys:userAccoutTextFild.text, @"username", userPasswordTextFild.text, @"password", @"ios", @"client", nil];
    [manager POST:SignIn parameters:signInParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dict);
        
        signInModel * SIModel = [signInModel setUserToken:dict];
        self.userToken = [signInModel sharedUserTokenInModel:SIModel];
        [self singnInBecomeUserData]; //获取用户信息
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.childBgSingnInView.hidden = NO;
        [self.actv stopAnimating];     //结束等待界面的动画
        [self.actv removeFromSuperview];
    }];
    //发送请求后跳转登录风火轮
    self.childBgSingnInView.hidden = YES;
    [self setIndicator];
}
#pragma mark -  如果有令牌，将会获取用户数据数据
-(void)singnInBecomeUserData
{
    if (self.userToken.whetherSignIn) { //判断是否登录成功
        [self.bgSignInview removeFromSuperview]; //登录成功，移除登录界面
        self.tabBarController.tabBar.hidden = NO;
        //请求我的商城
        AFHTTPRequestOperationManager *myManager = [AFHTTPRequestOperationManager manager];
        myManager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *myMallParameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userToken.key, @"key", nil];
        NSLog(@"%@", myMallParameters);
        [myManager POST:MyMall parameters:myMallParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dict);
            self.myMall = [fiveMyMallmodel setUserMall:dict];
            [self.actv stopAnimating];     //结束等待界面的动画
            [self.actv removeFromSuperview];
            [_tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            self.childBgSingnInView.hidden = NO;
            [self.actv stopAnimating];     //结束等待界面的动画
            [self.actv removeFromSuperview];
            [self setRegisterReason:@"没有网络"];
        }];
    }else
    {
        [self.actv stopAnimating];     //登录失败,结束等待界面的动画
        [self.actv removeFromSuperview];
        self.childBgSingnInView.hidden = NO; //登录失败再次显示登录按钮
        [self setRegisterReason:self.userToken.error];
    }
}
#pragma mark - 加载风火轮，并且开始转，前提是已经加载 了背景
-(void)setIndicator
{
    self.actv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.actv.center = self.view.center;
    [self.bgSignInview addSubview:self.actv];
    [self.actv startAnimating];     //开始等待界面的动画
}
#pragma mark - 加载没有请求注册的原因
-(void)setRegisterReason:(NSString *)string
{
    if (self.setLabel == nil) {
        self.setLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(340.0/2.0 - 20*string.length/2.0, 500, 20*string.length, 25)];
        self.setLabel.backgroundColor = [UIColor blackColor];
        self.setLabel.textColor = [UIColor whiteColor];
        self.setLabel.textAlignment = NSTextAlignmentCenter;
        self.setLabel.alpha = 0.8;
        self.setLabel.text = string;
        [self.bgSignInview addSubview:self.setLabel];
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
    }
}
-(void)setStoplabel
{
    [self.setLabel removeFromSuperview];
    self.setLabel = nil;
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
