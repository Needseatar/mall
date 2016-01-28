//
//  addAddressViewController.m
//  mall
//
//  Created by Mihua on 26/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "addAddressViewController.h"

@interface addAddressViewController ()<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (retain, nonatomic) UIView       *bgView;
@property (retain, nonatomic) UILabel      *addressRegionLbel;
@property (assign, nonatomic) BOOL         reginSelect; //判断是否已经选择了地区
@property (retain, nonatomic) UIButton     *AddAddressButton;

@property (retain, nonatomic) UIView       *pickerAndButtonView; //地区选择背景视图
@property (retain, nonatomic) UIPickerView *pickerView;

@property (retain, nonatomic) NSArray      *provinceArray; //保存了省的数据
@property (retain, nonatomic) NSString     *provinceNowOperation; //保存了请求所有省份请求数据的地址
@property (assign, nonatomic) BOOL         provinceNowBecome;   //省份数据是否回来

@property (retain, nonatomic) NSArray      *cityArray;   //保存了当前选择省的城市数据
@property (retain, nonatomic) NSString     *cityNowOperation; //保存了当前选择省请求数据的地址
@property (assign, nonatomic) BOOL         cityNowBecome;   //当前请求的省份id是否回来

@property (retain, nonatomic) NSArray      *areaArray;   //保存了当前城市选着的区的数据
@property (retain, nonatomic) NSString     *areaNowOperation; //保存了当前选择市请求数据的地址
@property (assign, nonatomic) BOOL         areaNowBecome;   //当前请求的省份id是否回来

@property (retain, nonatomic) NSString     *IDNow;      //当前请求的id

@property (retain, nonatomic) NSString     *provinceString;      //当前选择的省份
@property (retain, nonatomic) NSString     *cityString;      //当前选择的城市
@property (retain, nonatomic) NSString     *areaString;      //当前选择的地区

@property (retain, nonatomic) NSMutableArray *IDArray;      //保存了城市编号(地址联动的第二级)地区编号(地址联动的第三级)的字符串对象



@property (retain, nonatomic) UILabel           *errorRefresh; //数据没有输入提示

@end

@implementation addAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInitData]; //初始化数据
    
    [self setUserAddress]; //设置视图
    
    [self initPicker]; //设置地址选择器 和 按钮
    
    [self requestAreaAddressList:nil indexSection:0];  //请求省份
}

-(void)setInitData
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加地址";
    
    self.reginSelect = NO;
    
    self.IDArray = [[NSMutableArray alloc] init];
    
    self.provinceString = [[NSString alloc] init];
    self.cityString = [[NSString alloc] init];
    self.areaString = [[NSString alloc] init];
    
    self.provinceArray = [[NSArray alloc] init];
    self.cityArray = [[NSArray alloc] init];
    self.areaArray = [[NSArray alloc] init];
}

#pragma mark -  初始化PickerView使用的数据源
-(void)initPicker{
    self.pickerAndButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-180, self.view.frame.size.width, 180)];
    self.pickerAndButtonView.hidden = YES;
    [self.view addSubview:self.pickerAndButtonView];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
    self.pickerView.backgroundColor = greenColorDebug;
    self.pickerView.userInteractionEnabled = YES;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.pickerAndButtonView addSubview:self.pickerView];
    
    self.provinceArray = [[NSArray alloc] init];
    self.cityArray = [[NSArray alloc] init];
    self.areaArray = [[NSArray alloc] init];
    for (int i=0; i<3; i++) { //刷新数据
        [self.pickerView reloadComponent:i];
    }
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, self.pickerView.frame.size.height+self.pickerView.frame.origin.y, self.view.frame.size.width, self.pickerAndButtonView.frame.size.height-self.pickerView.frame.size.height);
    [but setBackgroundColor:[UIColor redColor]];
    [but setTitle:@"确定" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:18];
    [but addTarget:self action:@selector(addressDetermine) forControlEvents:UIControlEventTouchUpInside];
    but.userInteractionEnabled = NO;
    but.alpha=0.4;
    but.tag = 3474;
    [self.pickerAndButtonView addSubview:but];
    
}

-(void)addressDetermine
{
    
    self.AddAddressButton.userInteractionEnabled = YES;
    self.pickerAndButtonView.hidden = YES;
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
            UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [bgButton setBackgroundColor:greenColorDebug];
            bgButton.frame = CGRectMake(0, i*31, self.bgView.frame.size.width, 30);
            bgButton.tag = 10+i;
            [bgButton addTarget:self action:@selector(addressButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [self.bgView addSubview:bgButton];
            
            self.addressRegionLbel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bgView.frame.size.width-17, 30)];
            self.addressRegionLbel.text = arrayString[i];
            self.addressRegionLbel.backgroundColor = [UIColor whiteColor];
            [bgButton addSubview:self.addressRegionLbel];
            
            UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bgView.frame.size.width-17, self.addressRegionLbel.frame.size.height/2.0-15/2.0, 10, 15)];
            ImageView.backgroundColor = redColorDebug;
            ImageView.image = [UIImage imageNamed:@"accsessory_arrow_right@2x.png"];
            [bgButton addSubview:ImageView];
        }else
        {
            UITextField *textFil = [[UITextField alloc] initWithFrame:CGRectMake(0, i*31, self.bgView.frame.size.width, 30)];
            textFil.borderStyle = UITextBorderStyleNone;
            textFil.placeholder = arrayString[i];
            
            if (i==1 || i==2) {
                textFil.keyboardType = UIKeyboardTypeNumberPad;
            }else
            {
                textFil.keyboardType = UIKeyboardTypeDefault;
            }
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
    [self.AddAddressButton addTarget:self action:@selector(addAddressServer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.AddAddressButton];

}

#pragma mark -  添加地址到服务器
-(void)addAddressServer
{
    //回收键盘
    for (int i = 10; i<14; i++) {
        UITextField * userTextFild = (UITextField *)[self.view viewWithTag:i];
        [userTextFild resignFirstResponder];
    }
    
    //搜索输入栏的视图是否有输入的数据
    BOOL Whether=NO;
    NSString *prompt=nil;
    NSArray *arrayString = @[@"请输入收件人姓名",
                             @"请输入手机号码",
                             @"请输入电话号码",
                             @"请选择地区",
                             @"请输入详细地址"];
    for (int i=0; i<arrayString.count; i++) {
        if (i==2) {
            continue;
        }
        if (i==3) {
            if ([self.addressRegionLbel.text isEqualToString:@"所在地区"]) {
                prompt = arrayString[i];
                break;
            }
        }else
        {
            UITextField *textField = [self.bgView viewWithTag:10+i];
            if ([textField.text isEqualToString:@""]) {
                prompt = arrayString[i];
                break;
            }
        }
        if (i==4) {
            Whether = YES;
        }
    }
    
    if (Whether) { //数据正确，提交地址
        signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
        if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
            
            NSArray *addressKey = @[@"true_name",
                                    @"city_id",
                                    @"area_id",
                                    @"area_info",
                                    @"address",
                                    @"mob_phone",
                                    @"tel_phone"];
            
            NSMutableArray *addressObject = [[NSMutableArray alloc] init];
            for (int i=0; i<arrayString.count; i++) {
                UITextField *textFil = [self.bgView viewWithTag:10+i];
                if (i==3) {
                    [addressObject addObject:self.addressRegionLbel.text];
                    continue;
                }
                [addressObject addObject:textFil.text];
            }
            
            NSDictionary *addAddressDic;
            if ([addressObject[2] isEqualToString:@""]) {
                addAddressDic =
                [NSDictionary dictionaryWithObjectsAndKeys:
                 signIn.key, @"key",
                 addressObject[0], addressKey[0],
                 self.IDArray[0], addressKey[1],
                 self.IDArray[0], addressKey[2],
                 self.addressRegionLbel.text, addressKey[3],
                 addressObject[4], addressKey[4],
                 addressObject[1], addressKey[5], nil];
            }else
            {
                addAddressDic =
                [NSDictionary dictionaryWithObjectsAndKeys:
                 signIn.key, @"key",
                 addressObject[0], addressKey[0],
                 self.IDArray[0], addressKey[1],
                 self.IDArray[0], addressKey[2],
                 self.addressRegionLbel.text, addressKey[3],
                 addressObject[4], addressKey[4],
                 addressObject[1], addressKey[5],
                 addressObject[2], addressKey[6], nil];
            }
            
            //加载请求地址数据视图
            UIView *bgActionView = [[UIView alloc] initWithFrame:self.view.frame];
            bgActionView.backgroundColor = [UIColor blackColor];
            bgActionView.alpha = 0.7;
            [self.view addSubview:bgActionView];
             UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(bgActionView.frame.size.width/2.0-30/2.0, bgActionView.frame.size.height/2.0-30/2.0, 30.0, 30.0)];
            [aiView startAnimating];
            aiView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            [bgActionView addSubview:aiView];
            
            //请求增加数据
            [manager POST:AddAddress parameters:addAddressDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@", operation.responseSerializer);
                NSLog(@"JSON: %@", dict);
                
                [bgActionView removeFromSuperview];
                //返回第二层目录
                [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -3)] animated:YES];
                
            }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                NSLog(@"Error: %@", error);
                [bgActionView removeFromSuperview];
            }];
        }else //没有令牌，也就是没有登录
        {
            
        }
    }else //数据错误， 提示哪里没有一输入
    {
        if (self.errorRefresh==nil) {
            self.errorRefresh = [loadingImageView setNetWorkRefreshError:self.view.frame viewString:prompt];
            [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setStoplabel) userInfo:nil repeats:NO];
            [self.view addSubview:self.errorRefresh];
        }
    }
}

#pragma mark - 所在区选择
-(void)addressButtonAction
{
    [self keyboardAction];
    self.AddAddressButton.userInteractionEnabled = NO;
    self.pickerAndButtonView.hidden = NO;
    //设置地区
    self.addressRegionLbel.text = [NSString stringWithFormat:@"%@ %@ %@",
                                   self.provinceString,
                                   self.cityString,
                                   self.areaString];

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
            [self addAddressServer];
            break;
        }
        default:
            break;
    }
    return YES;
}

#pragma mark - 回收键盘
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

#pragma mark - 请求地址数据
//areaID是请求的id ，indexSection是请求第几组的数据
-(void)requestAreaAddressList:(NSString *)areaID indexSection:(int)indexSection{
    
    signInModel *signIn = [signInModel sharedUserTokenInModel:[signInModel initSingleCase]];
    if ([signIn.key isKindOfClass:[NSString class]] && signIn.whetherSignIn == YES) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
        NSDictionary *signInAddress;
        
        switch (indexSection) {
            case 0:
            {
                signInAddress =
                [NSDictionary dictionaryWithObjectsAndKeys:
                 signIn.key, @"key",
                 nil];
                self.provinceNowOperation = [NSString stringWithFormat:@"%@", manager.responseSerializer];
                self.provinceNowBecome = NO;
                for (int i=0; i<3; i++) {
                    [self.pickerView reloadComponent:i];
                }
                break;
            }
            case 1:
            {
                signInAddress =
                [NSDictionary dictionaryWithObjectsAndKeys:
                 signIn.key, @"key", areaID, @"area_id",
                 nil];
                self.cityNowOperation = [NSString stringWithFormat:@"%@", manager.responseSerializer];
                self.cityNowBecome = NO;
                for (int i=1; i<3; i++) {
                    [self.pickerView reloadComponent:i];
                }
                break;
            }
            case 2:
            {
                signInAddress =
                [NSDictionary dictionaryWithObjectsAndKeys:
                 signIn.key, @"key", areaID, @"area_id",
                 nil];
                self.areaNowOperation = [NSString stringWithFormat:@"%@", manager.responseSerializer];
                self.areaNowBecome = NO;
                [self.pickerView reloadComponent:2];
                break;
            }
            default:
                break;
        }
        
        self.IDNow = areaID;
        
        [manager POST:AreaAddressList parameters:signInAddress success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", operation.responseSerializer);
            NSLog(@"JSON: %@", dict);
            if ([self.provinceNowOperation isEqualToString:[NSString stringWithFormat:@"%@", operation.responseSerializer]]) { //所有省份都请求回来
                self.provinceArray = [addressAreaModel setValueWithDictionary:dict];
                self.provinceNowBecome = YES;
                self.provinceString = [self.provinceArray[0] area_name];
                self.cityArray = [[NSArray alloc] init];
                self.areaArray = [[NSArray alloc] init];
                
                self.IDNow = [NSString stringWithFormat:@"%@", [self.provinceArray[0] area_id]];
                [self requestAreaAddressList:self.IDNow indexSection:1];  //请求省份对应的城市
            }else if ([self.cityNowOperation isEqualToString:[NSString stringWithFormat:@"%@", operation.responseSerializer]]) { //当前的城市数据请求回来
                self.cityArray = [addressAreaModel setValueWithDictionary:dict];
                self.cityNowBecome = YES;
                self.cityString = [self.cityArray[0] area_name];
                self.areaArray = [[NSArray alloc] init];
                
                self.IDArray = [[NSMutableArray alloc] init]; //重置请求的id
                [self.IDArray addObject:self.IDNow]; //保存数据编号
                
                self.IDNow = [NSString stringWithFormat:@"%@", [self.cityArray[0] area_id]];
                [self requestAreaAddressList:self.IDNow indexSection:2];  //请求城市对应的区
            }else if ([self.areaNowOperation isEqualToString:[NSString stringWithFormat:@"%@", operation.responseSerializer]]) //当前的区的数据请求回来
            {
                if (self.IDArray.count == 1) {
                    [self.IDArray addObject:self.IDNow]; //保存数据编号
                }else if (self.IDArray.count > 1)
                {
                    self.IDArray[1] = self.IDNow; //保存数据编号
                }
                
                //三级地址请求回来，确定可以按下
                UIButton *but = [self.pickerAndButtonView viewWithTag:3474];
                but.userInteractionEnabled = YES;
                but.alpha=1;
                
                self.areaNowBecome = YES;
                self.areaArray = [addressAreaModel setValueWithDictionary:dict];
                self.areaString = [self.areaArray[0] area_name];
                
                if (self.pickerAndButtonView.hidden == NO) {
                    self.addressRegionLbel.text = [NSString stringWithFormat:@"%@ %@ %@",
                                                   self.provinceString,
                                                   self.cityString,
                                                   self.areaString];
                }
            }
            for (int i=0; i<3; i++) { //刷新数据
                [self.pickerView reloadComponent:i];
            }
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"Error: %@", error);
        }];
    }else //没有令牌，也就是没有登录
    {
        
    }
}

#pragma mark 实现协议UIPickerViewDelegate方法
//以下3个方法实现PickerView的数据初始化
//确定picker的轮子个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {//省份个数
        return self.provinceArray.count;
    } else if(component == 1){//市的个数
        return [self.cityArray count];
    }else if(component == 2)//区的个数
    {
        return [self.areaArray count];
    }else
    {
        return 0;
    }
}
//确定每个轮子的每一项显示什么内容
-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {//省份名
        return [self.provinceArray[row] area_name] ;
    } else if(component == 1){//市名
        return [self.cityArray[row] area_name];
    }else if(component == 2)//区名
    {
        return [self.areaArray[row] area_name];
    }else
    {
        return @"";
    }
}

//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        
        //设置如果三级地址没有请求回来，就不能确定
        UIButton *but = [self.pickerAndButtonView viewWithTag:3474];
        but.userInteractionEnabled = NO;
        but.alpha=0.4;
        
        self.IDNow = [NSString stringWithFormat:@"%@", [self.provinceArray[row] area_id]];
        self.provinceString = [self.provinceArray[row] area_name]; //保存选择的省
        self.cityString = @"";
        self.areaString = @"";
        [self requestAreaAddressList:self.IDNow indexSection:1];  //请求省份对应的城市
        
        
        self.cityArray = [[NSArray alloc] init];
        self.areaArray = [[NSArray alloc] init];
        [self.pickerView reloadComponent:1];//第二列重新读值（刷新）
        [self.pickerView reloadComponent:2];//第三列重新读值（刷新）
    }else  if (component == 1){
        self.IDNow = [NSString stringWithFormat:@"%@", [self.cityArray[row] area_id]];
        self.cityString = [self.cityArray[row] area_name]; //保存选择的市
        self.areaString = @"";
        [self requestAreaAddressList:self.IDNow indexSection:2];  //请求城市对应的区
        
        self.areaArray = [[NSArray alloc] init];
        [self.pickerView reloadComponent:2];//第三列重新读值（刷新）
    }else
    {
        self.areaString = [self.areaArray[row] area_name]; //保存选择的区
    }
    self.addressRegionLbel.text = [NSString stringWithFormat:@"%@ %@ %@",
                                   self.provinceString,
                                   self.cityString,
                                   self.areaString];
}

-(void)setStoplabel
{
    [self.errorRefresh removeFromSuperview];
    self.errorRefresh = nil;
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
