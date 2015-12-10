//
//  fiveRegisteredViewController.m
//  mall
//
//  Created by Mihua on 24/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fiveRegisteredViewController.h"

@interface fiveRegisteredViewController ()<UITextFieldDelegate>

@property (retain, nonatomic) UIView      *bgTextView;
@property (retain, nonatomic) UITextField *userTextField;
@property (retain, nonatomic) UITextField *mailTextField;
@property (retain, nonatomic) UITextField *passwordTextField;
@property (retain, nonatomic) UITextField *againPasswordTextField;

@property (retain, nonatomic) UIView      *bgAgreementView;
@property (retain, nonatomic) UIButton    *agreementButton;
@property (retain, nonatomic) UIButton    *registrationButton;

@property (strong, nonatomic) signInModel *userToken;

@property (retain, nonatomic) UIView      *bgSignInview;      //登录时背景视图
@property (retain, nonatomic) UIActivityIndicatorView * actv; //风火轮

@property (retain, nonatomic) UILabel     *setLabel;

@end


@implementation fiveRegisteredViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO; //隐藏导航控制器
    
    self.tabBarController.tabBar.hidden =  YES;  //便签控制器不隐藏
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    
    [self setTextView]; //加载注册视图
    
    [self setButton];
}

-(void)setNavigation
{
    self.title = @"注册";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
}

-(void)setTextView
{
    //在视图添加点击后回收键盘动作
    UITapGestureRecognizer * keyboardTapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardAction)];//加载点击动作
    [self.view addGestureRecognizer:keyboardTapAction];
    
    //注册资料背景视图
    self.bgTextView = [[UIView alloc] initWithFrame:CGRectMakeEx(10, 80, 300, 123)];
    self.bgTextView.backgroundColor = [UIColor grayColor];
    self.bgTextView.layer.masksToBounds = YES;  //告诉layer将位于它之下的layer都遮盖住
    self.bgTextView.layer.cornerRadius =3;
    self.bgTextView.layer.borderWidth = 1;//边框宽度
    self.bgTextView.layer.borderColor = [[UIColor grayColor] CGColor];//边框颜色
    [self.view addSubview:self.bgTextView];
    
    //用户账号
    self.userTextField = [[UITextField alloc] initWithFrame:CGRectMakeEx(0, 0, 300, 30)];
    self.userTextField.borderStyle = UITextBorderStyleNone;
    self.userTextField.placeholder = @"用户名";
    self.userTextField.backgroundColor = [UIColor whiteColor];
    self.userTextField.tag = 10;
    self.userTextField.delegate = self;
    [self.userTextField becomeFirstResponder];
    [self.bgTextView addSubview:self.userTextField];
    
    //用户邮箱
    self.mailTextField = [[UITextField alloc] initWithFrame:CGRectMakeEx(0, 31, 300, 30)];
    self.mailTextField.borderStyle = UITextBorderStyleNone;
    self.mailTextField.placeholder = @"邮箱";
    self.mailTextField.backgroundColor = [UIColor whiteColor];
    self.mailTextField.tag = 11;
    self.mailTextField.delegate = self;
    [self.bgTextView addSubview:self.mailTextField];
    
    //用户密码
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMakeEx(0, 62, 300, 30)];
    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.placeholder = @"密码";
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.secureTextEntry = YES; //输入的字符不显示出来
    self.passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;  //设置键盘不大写
    self.passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo; //设置密码输入键盘
    self.passwordTextField.tag = 12;
    self.passwordTextField.delegate = self;
    [self.bgTextView addSubview:self.passwordTextField];
    
    //确认密码
    self.againPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMakeEx(0, 93, 300, 30)];
    self.againPasswordTextField.borderStyle = UITextBorderStyleNone;
    self.againPasswordTextField.placeholder = @"确认密码";
    self.againPasswordTextField.backgroundColor = [UIColor whiteColor];
    self.againPasswordTextField.secureTextEntry = YES; //输入的字符不显示出来
    self.againPasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;  //设置键盘不大写
    self.againPasswordTextField.autocorrectionType = UITextAutocorrectionTypeNo; //设置密码输入键盘
    self.againPasswordTextField.tag = 13;
    self.againPasswordTextField.delegate = self;
    [self.bgTextView addSubview:self.againPasswordTextField];
    
    
}

#pragma mark - 加载用户注册和注册按钮
-(void)setButton
{
    //用户协议
    self.bgAgreementView = [[UIView alloc] initWithFrame:CGRectMakeEx(10, 220, 200, 20)];
    //self.bgAgreementView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.bgAgreementView];
    
    self.agreementButton = [[UIButton alloc] initWithFrame:CGRectMakeEx(0, 0, 20, 20)];
    self.agreementButton.selected = YES;
    [self.agreementButton setBackgroundImage:[UIImage imageNamed:@"accsessory_check.png"] forState:UIControlStateSelected];
    [self.agreementButton addTarget:self action:@selector(agreementButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.agreementButton.layer.masksToBounds = YES; // 超出部分覆盖
    self.agreementButton.layer.borderWidth = 1;//边框宽度
    self.agreementButton.layer.borderColor = [[UIColor blackColor] CGColor];//边框颜色
    [self.bgAgreementView addSubview:self.agreementButton];
    
    UILabel *agreementlabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(25, 0, 180, 20)];
    agreementlabel.text = @"阅读协议";
    [self.bgAgreementView addSubview:agreementlabel];
    
    //注册按钮
    self.registrationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.registrationButton setFrame:CGRectMakeEx(120, 250, 80, 30)];
    [self.registrationButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]];
    [self.registrationButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registrationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registrationButton addTarget:self action:@selector(registrationButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registrationButton];
    
}
-(void)agreementButtonAction
{
    if (self.agreementButton.selected == YES) {
        self.agreementButton.selected = NO;
    }else
    {
        self.agreementButton.selected = YES;
    }
}
-(void)registrationButtonAction
{
    //回收键盘
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i = 10; i<14; i++) {
        UITextField * userTextFild = (UITextField *)[self.view viewWithTag:i];
        [mArray addObject:userTextFild];
    }
    for (int i=0; i<mArray.count; i++) {
        [mArray[i] resignFirstResponder];
    }
    
    BOOL whetherUserVoid = [self.userTextField.text isEqualToString:@""]? YES: NO;
    BOOL whetherEmailVoid = [self.mailTextField.text isEqualToString:@""]? YES: NO;
    BOOL whetherPasswordVoid = [self.passwordTextField.text isEqualToString:@""]? YES: NO;
    BOOL whetherPasswordConfirmVoid = [self.againPasswordTextField.text isEqualToString:@""]? YES: NO;
    BOOL whetherPasswordAndAgain = [self.passwordTextField.text isEqualToString:self.againPasswordTextField.text]? YES: NO;
    if (whetherUserVoid==NO &&
        whetherEmailVoid==NO &&
        whetherPasswordVoid==NO &&
        whetherPasswordConfirmVoid == NO &&
        self.agreementButton.selected == YES) {
        if (whetherPasswordAndAgain) {
            //注册接口
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
            
            NSDictionary *myMallParameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userTextField.text, @"username", self.passwordTextField.text, @"password", self.againPasswordTextField.text, @"password_confirm", self.mailTextField.text, @"email",  @"ios",  @"client",nil];
            NSLog(@"%@", myMallParameters);
            [manager POST:Registration parameters:myMallParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@", dict);
                signInModel *signInToken = [signInModel setUserToken:dict];
                self.userToken = [signInModel sharedUserTokenInModel:signInToken]; //将用户的登录令牌和信息存入单例
                [self.bgSignInview removeFromSuperview];
                if (self.userToken.whetherSignIn == YES) {
                    [self.navigationController popToRootViewControllerAnimated:YES]; //退出注册界面，返回登录界面
                }else
                {
                    NSLog(@"%@", self.userToken.error);
                    [self setRegisterReason:self.userToken.error];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                [self.bgSignInview removeFromSuperview];
                [self setRegisterReason:@"请求失败"];
            }];
            [self setSignInBGView]; //加载等待背景
            [self setIndicator];    //加载等待风火轮
        }else
        {
            NSLog(@"两次输入的密码不一致");
            [self setRegisterReason:@"两次输入的密码不一致"];
            
        }
    }else if (self.agreementButton.selected == NO){
        NSLog(@"请阅读并同意用户协议");
        [self setRegisterReason:@"请阅读并同意用户协议"];
    }else if(whetherUserVoid)
    {
        NSLog(@"账号不能空");
        [self setRegisterReason:@"账号不能空"];
    }else if (whetherEmailVoid)
    {
        NSLog(@"邮箱不能为空");
        [self setRegisterReason:@"邮箱不能为空"];
    }else if (whetherPasswordVoid)
    {
        NSLog(@"密码不能空");
        [self setRegisterReason:@"密码不能空"];
    }else if (whetherPasswordConfirmVoid)
    {
        NSLog(@"确认密码不能空");
        [self setRegisterReason:@"确认密码不能空"];
    }
    
    NSLog(@"%d,%d,%d,%d,%d", whetherUserVoid, whetherEmailVoid, whetherPasswordVoid, whetherPasswordConfirmVoid, whetherPasswordAndAgain);
    
}

#pragma mark - 当用户点击return键的时候执行该方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i = 10; i<14; i++) {
        UITextField * userTextFild = (UITextField *)[self.view viewWithTag:i];
        [mArray addObject:userTextFild];
    }
    switch (textField.tag) {
        case 10:
        {
            [textField resignFirstResponder];
            [mArray[1] becomeFirstResponder];
            break;
        }
        case 11:
        {
            [textField resignFirstResponder];
            [mArray[2] becomeFirstResponder];
            break;
        }
        case 12:
        {
            [textField resignFirstResponder];
            [mArray[3] becomeFirstResponder];
            break;
        }
        case 13:
        {
            [textField resignFirstResponder];
            [self registrationButtonAction];
            break;
        }
        default:
            break;
    }
    return YES;
}

#pragma mark - 设置注册背景遮盖
-(void)setSignInBGView
{
    //背景遮盖
    self.bgSignInview = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 0, 340, 600)];
    self.bgSignInview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5]; //设置的alpha只在子视图中没有继承
    self.tabBarController.tabBar.hidden = YES;
    self.bgSignInview.userInteractionEnabled = YES;
    [self.view addSubview:self.bgSignInview];
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
        [self.view addSubview:self.setLabel];
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
    }
}
-(void)setStoplabel
{
    [self.setLabel removeFromSuperview];
    self.setLabel = nil;
}

#pragma mark - 视图点击回收键盘
-(void)keyboardAction
{
    for (int i = 10; i<14; i++) {
        UITextField * userTextFild = (UITextField *)[self.view viewWithTag:i];
        [userTextFild resignFirstResponder];
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
