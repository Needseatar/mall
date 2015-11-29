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
    
    
    self.registrationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.registrationButton setFrame:CGRectMakeEx(120, 250, 80, 30)];
    [self.registrationButton setBackgroundColor:[UIColor redColor]];
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
    BOOL whetherUserVoid = [self.userTextField.text isEqualToString:@""]? NO: YES;
    BOOL whetherEmailVoid = [self.mailTextField.text isEqualToString:@""]? NO: YES;
    BOOL whetherPasswordVoid = [self.passwordTextField.text isEqualToString:@""]? NO: YES;
    BOOL whetherPasswordConfirmVoid = [self.againPasswordTextField.text isEqualToString:@""]? NO: YES;
    BOOL whetherPasswordAndAgain = [self.passwordTextField.text isEqualToString:self.againPasswordTextField.text]? YES: NO;
    if (whetherUserVoid == whetherEmailVoid == whetherPasswordVoid == whetherPasswordConfirmVoid == NO && self.agreementButton.selected == YES) {
        if (whetherPasswordAndAgain) {
            //注册接口
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
            
            NSDictionary *myMallParameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userTextField.text, @"username", self.passwordTextField.text, @"password", self.againPasswordTextField, @"password_confirm", self.mailTextField, @"email",  @"ios",  @"client",nil];
            [manager POST:Registration parameters:myMallParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
                NSLog(@"%@", dict);
//                if ([dict[@"datas"] integerValue] == 1) {
////                    [self.actv stopAnimating];     //结束等待界面的动画
////                    [self.bgSignInview removeFromSuperview];
////                    signInModel * cancellationModel = [signInModel initSetUser];
////                    self.userToken = [signInModel sharedUserTokenInModel:cancellationModel]; //清空登录令牌
//                }else
//                {
//                    
//                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
//                self.childBgSingnInView.hidden = NO;
//                [self.actv stopAnimating];     //结束等待界面的动画
//                [self.actv removeFromSuperview];
            }];
        }else
        {
            NSLog(@"两次输入的密码不正确");
        }
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
            break;
        }
        default:
            break;
    }
    return YES;
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
