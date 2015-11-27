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