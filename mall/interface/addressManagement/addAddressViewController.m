//
//  addAddressViewController.m
//  mall
//
//  Created by Mihua on 26/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "addAddressViewController.h"

@interface addAddressViewController ()<UITextFieldDelegate>

@property (retain, nonatomic) UIView      *bgView;
@property (retain, nonatomic) UILabel     *addressRegionLbel;
@property (assign, nonatomic) BOOL        reginSelect; //判断是否已经选择了地区
@property (retain, nonatomic) UIButton    *AddAddressButton;

@end

@implementation addAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加地址";
    
    self.reginSelect = NO;
    
    [self setUserAddress]; //设置视图
}

-(void)setUserAddress
{
    //在视图添加点击后回收键盘动作
    UITapGestureRecognizer * keyboardTapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardAction)];//加载点击动作
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:keyboardTapAction];
    
    //背景视图
    self.bgView = [[UIView alloc] init];
    self.bgView.frame = CGRectMake(5, UpState+Navigation+15, self.view.frame.size.width-2*5, 200);
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.layer.masksToBounds = YES;  //告诉layer将位于它之下的layer都遮盖住
    self.bgView.layer.cornerRadius =3;
    self.bgView.layer.borderWidth = 1;//边框宽度
    self.bgView.layer.borderColor = [[UIColor grayColor] CGColor];//边框颜色
    [self.view addSubview:self.bgView];
    
    NSArray *arrayString = @[@"收件人姓名(必填)",
                             @"手机号码(必填)",
                             @"电话号码",
                             @"所在地区",
                             @"详细地址(必填)"];
    for (int i=0; i<arrayString.count; i++) {
        if (i==3) {
            self.addressRegionLbel = [[UILabel alloc] initWithFrame:CGRectMake(0, i*31, self.bgView.frame.size.width-17, 30)];
            self.addressRegionLbel.text = arrayString[i];
            self.addressRegionLbel.backgroundColor = [UIColor whiteColor];
            self.addressRegionLbel.tag = 10+i;
            [self.bgView addSubview:self.addressRegionLbel];
            
            UIView *imageViewBG = [[UIView alloc] init];
            imageViewBG.backgroundColor =greenColorDebug;
            imageViewBG.frame = CGRectMake(self.bgView.frame.size.width-17, i*31, 15, 30);
            [self.bgView addSubview:imageViewBG];
            
            UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.addressRegionLbel.frame.size.height/2.0-15/2.0, 10, 15)];
            ImageView.backgroundColor = redColorDebug;
            ImageView.image = [UIImage imageNamed:@"accsessory_arrow_right@2x.png"];
            [imageViewBG addSubview:ImageView];
        }else
        {
            UITextField *textFil = [[UITextField alloc] initWithFrame:CGRectMake(0, i*31, self.bgView.frame.size.width, 30)];
            textFil.borderStyle = UITextBorderStyleNone;
            textFil.placeholder = arrayString[i];
            textFil.backgroundColor = [UIColor whiteColor];
            textFil.tag = 10+i;
            textFil.delegate = self;
            if (i==0) {
                [textFil becomeFirstResponder];
            }
            [self.bgView addSubview:textFil];
        }
        //设置背景视图高度
        if (i==arrayString.count-1) {
            UIView *vi = [self.bgView viewWithTag:10+i];
            CGRect fr = self.bgView.frame;
            fr.size.height = vi.frame.origin.y+vi.frame.size.height;
            self.bgView.frame = fr;
        }
    }
    
    //设置添加button按钮
    self.AddAddressButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.AddAddressButton.frame = CGRectMake(self.view.frame.size.width/2.0-130/2.0, UpState+Navigation+180, 130, 50);
    [self.AddAddressButton setBackgroundColor:[UIColor colorWithRed:36/255.0f green:158/255.0f blue:246/255.0f alpha:1]];
    self.AddAddressButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.AddAddressButton setTitle:@"添加地址" forState:UIControlStateNormal];
    [self.AddAddressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.AddAddressButton];

}

#pragma mark - 当用户点击return键的时候执行该方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i = 10; i<15; i++) {
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
            [mArray[4] becomeFirstResponder];
            break;
        }
        case 14:
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
    for (int i = 10; i<15; i++) {
        if (i==13) {
            continue;
        }
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
