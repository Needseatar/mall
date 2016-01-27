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

@property (retain, nonatomic) UIView       *pickerAndButtonView;
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

@end

@implementation addAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加地址";
    
    self.reginSelect = NO;
    
    [self setUserAddress]; //设置视图
    
    [self initPicker]; //设置地址选择器 和 按钮
    
    [self requestAreaAddressList:nil indexSection:0];  //请求省份
}

#pragma mark -  初始化PickerView使用的数据源
-(void)initPicker{
    self.provinceArray = [[NSArray alloc] init];
    self.cityArray = [[NSArray alloc] init];
    self.areaArray = [[NSArray alloc] init];
    
    
    self.pickerAndButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-180, self.view.frame.size.width, 180)];
    self.pickerAndButtonView.userInteractionEnabled = YES;
    self.pickerAndButtonView.hidden = YES;
    [self.view addSubview:self.pickerAndButtonView];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
    self.pickerView.backgroundColor = greenColorDebug;
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
    [self.pickerAndButtonView addSubview:but];
    
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
#pragma mark - 所在区选择
-(void)addressButtonAction
{
    [self keyboardAction];
    self.pickerAndButtonView.hidden = NO;
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
                
                self.cityArray = [[NSArray alloc] init];
                self.areaArray = [[NSArray alloc] init];
                
                self.IDNow = [NSString stringWithFormat:@"%@", [self.provinceArray[0] area_id]];
                [self requestAreaAddressList:self.IDNow indexSection:1];  //请求省份对应的城市
            }else if ([self.cityNowOperation isEqualToString:[NSString stringWithFormat:@"%@", operation.responseSerializer]]) { //当前的城市数据请求回来
                self.cityArray = [addressAreaModel setValueWithDictionary:dict];
                self.cityNowBecome = YES;
                self.areaArray = [[NSArray alloc] init];
                
                self.IDNow = [NSString stringWithFormat:@"%@", [self.cityArray[0] area_id]];
                [self requestAreaAddressList:self.IDNow indexSection:2];  //请求城市对应的区
            }else if ([self.areaNowOperation isEqualToString:[NSString stringWithFormat:@"%@", operation.responseSerializer]]) //当前的区的数据请求回来
            {
                self.areaNowBecome = YES;
                self.areaArray = [addressAreaModel setValueWithDictionary:dict];
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
        self.IDNow = [NSString stringWithFormat:@"%@", [self.provinceArray[row] area_id]];
        self.provinceString = [self.provinceArray[row] area_name]; //保存选择的省
        self.cityString = @"";
        self.areaString = @"";
        [self requestAreaAddressList:self.IDNow indexSection:1];  //请求省份对应的城市
    }else  if (component == 1){
        self.IDNow = [NSString stringWithFormat:@"%@", [self.cityArray[row] area_id]];
        self.cityString = [self.cityArray[row] area_name]; //保存选择的市
        self.areaString = @"";
        [self requestAreaAddressList:self.IDNow indexSection:2];  //请求城市对应的区
    }else
    {
        self.areaString = [self.areaArray[row] area_name]; //保存选择的区
    }
    self.addressRegionLbel.text = [NSString stringWithFormat:@"%@ %@ %@",
                                   self.provinceString,
                                   self.cityString,
                                   self.areaString];
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
