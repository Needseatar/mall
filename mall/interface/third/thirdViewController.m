//
//  thirdViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//

#import "thirdViewController.h"

#define Deviation 80  // 设置字体偏移的距离
#define AnimationTime   0.5  //设置动画时间

@interface thirdViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar    *searchBar;
@property (nonatomic, strong) NSArray        *mArry;

@property (nonatomic, retain) NSMutableArray *mRectBeginArray; //开始时候but的位置
@property (nonatomic, retain) NSMutableArray *mRectArray;     //结束时候的位置
@property (nonatomic, retain) NSMutableArray *mColorArray;    //but的颜色

@property (nonatomic, retain) UIView         *errorNetwork;   //网络加载失败
@property (nonatomic, retain) UIView         *loadingiew;   //加载网络视图

@end

@implementation thirdViewController

#pragma mark - 设置按钮显示 返回
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    for (UIView *suView in [self.view subviews]) {  //移除视图上的空间
        [suView removeFromSuperview];
    }
    [self requestSearchText]; //请求数据
    [self setLoadingView];   //加载加载视图
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchBar];  //设置导航栏
    
    //在视图上添加点击操作收回键盘
    UITapGestureRecognizer * attentionTapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attentionAction)];//加载点击动作
    [self.view addGestureRecognizer:attentionTapAction];
    self.view.userInteractionEnabled = YES;
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setLoadingView
{
    CGRect fr = CGRectMake(self.view.frame.size.width/2.0-40, self.view.frame.size.height/2.0-40, 80, 80);
    self.loadingiew = [loadingImageView setLoadingImageView:fr];
    [self.view addSubview:self.loadingiew];
}

-(void)attentionAction
{
    [self.searchBar resignFirstResponder];
}

-(void)setButtonRandom
{
    self.mRectArray = [[NSMutableArray alloc] init];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i=0; i<84; i++) {
        CGRect frame = CGRectMakeEx((i%6)*50+10, (i/6)*30+10, 60, 30); //设置7列12行 ，会有10像素重叠，但是设置了不重复条件，所以不会选到两个重叠的
        [mArray addObject:[NSValue valueWithCGRect:frame]];
    }
    
    for (int i=0; i<6; i++) {
        CGRect rect = [[mArray objectAtIndex:arc4random()%83] CGRectValue];
        
        for (int j=0; j<self.mRectArray.count; j++) {//判断和之前的数据是否重叠
            NSLog(@"%d", j);
            CGRect sssss =  [[self.mRectArray objectAtIndex:j] CGRectValue];
            
            if (sssss.origin.x==rect.origin.x) {
                j=-1;
                rect = [[mArray objectAtIndex:arc4random()%83] CGRectValue];
                continue;
            }
            if (sssss.origin.y==rect.origin.y) {
                j=-1;
                rect = [[mArray objectAtIndex:arc4random()%83] CGRectValue];
                continue;
            }
        }
        
        [self.mRectArray addObject:[NSValue valueWithCGRect:rect]];
    }
    self.mRectBeginArray = [[NSMutableArray alloc] init];
    for (int i=0; i<self.mArry.count; i++) {
        CGRect cgre22 = [[self.mRectArray objectAtIndex:i] CGRectValue];
        
        float k = (cgre22.origin.y-250)/(float)(cgre22.origin.x-160);
        NSLog(@"%f", k);
        float b = (float)250 - k*(float)160;
        
        if (cgre22.origin.x>=160 && cgre22.origin.y<250) {  //第一象限
            if (cgre22.origin.x==160) {
                cgre22 = CGRectMake(cgre22.origin.x, cgre22.origin.y-Deviation, cgre22.size.width, cgre22.size.height);
            }else
            {
                cgre22 = CGRectMake(cgre22.origin.x+Deviation, k*(float)(cgre22.origin.x+Deviation)+b, cgre22.size.width, cgre22.size.height);
            }
        }else if (cgre22.origin.x<160 && cgre22.origin.y<250)//第二象限
        {
            cgre22 = CGRectMake(cgre22.origin.x-Deviation, k*(float)(cgre22.origin.x-Deviation)+b, cgre22.size.width, cgre22.size.height);
        }else if (cgre22.origin.x<=160 && cgre22.origin.y>=250)//第三象限
        {
            if (cgre22.origin.y==250 && cgre22.origin.x==160) {
                cgre22 = CGRectMake(cgre22.origin.x-Deviation, cgre22.origin.y+Deviation, cgre22.size.width, cgre22.size.height);
            }else if (cgre22.origin.y==250)
            {
                cgre22 = CGRectMake(cgre22.origin.x-Deviation, cgre22.origin.y, cgre22.size.width, cgre22.size.height);
            }else if (cgre22.origin.x==160)
            {
                cgre22 = CGRectMake(cgre22.origin.x, cgre22.origin.y+Deviation, cgre22.size.width, cgre22.size.height);
            }else
            {
                cgre22 = CGRectMake(cgre22.origin.x-Deviation, k*(float)(cgre22.origin.x-Deviation)+b, cgre22.size.width, cgre22.size.height);
            }
        }else if(cgre22.origin.x>160 && cgre22.origin.y>=250)//第四象限
        {
            if (cgre22.origin.y==250) {
                cgre22 = CGRectMake(cgre22.origin.x+Deviation, cgre22.origin.y, cgre22.size.width, cgre22.size.height);
            }else
            {
                cgre22 = CGRectMake(cgre22.origin.x+Deviation, k*(float)(cgre22.origin.x+Deviation)+b, cgre22.size.width, cgre22.size.height);
            }
        }
        [self.mRectBeginArray addObject:[NSValue valueWithCGRect:cgre22]];
    }
    
    self.mColorArray = [[NSMutableArray alloc] init];
    for (int i=0; i<self.mArry.count; i++) {
        UIColor *color = [UIColor colorWithRed:(arc4random()%119)/255.0f green:(arc4random()%255)/255.0f blue:(arc4random()%255)/255.0f alpha:1];
        [self.mColorArray addObject:color];
    }
}

-(void)setButton
{
    for (int i=0; i<self.mArry.count; i++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitleColor:self.mColorArray[i] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:18];
        [but setTitle:self.mArry[i] forState:UIControlStateNormal];
        but.layer.shadowOffset=CGSizeMake(6, 6); //设置偏移
        but.layer.shadowOpacity=0.8;  //设置影子
        
        but.frame= [[self.mRectBeginArray objectAtIndex:i] CGRectValue];  //按钮开始位置
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:AnimationTime];//动画时间
        [UIView setAnimationDelegate:self];
        but.frame=  [[self.mRectArray objectAtIndex:i] CGRectValue];//动画结束时候位置
        [UIView commitAnimations];
        
        
        [but addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside]; //加载动作
        [self.view addSubview:but];
    }
}

-(void)buttonAction:(UIButton *)but
{
    self.searchBar.text = but.titleLabel.text;
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMakeNavigationEx(20, 0, 240, 40, changeWidth)];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
    
    //右边搜索按钮
    UIButton * rightCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightCamera setTitle:@"搜索" forState:UIControlStateNormal];
    [rightCamera setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightCamera.frame = CGRectMakeNavigationEx(0, 0, 45, 25, changeWidth);
    UIBarButtonItem * rightCameraItem = [[UIBarButtonItem alloc] initWithCustomView:rightCamera];
    self.navigationItem.rightBarButtonItem = rightCameraItem;
    
}
#pragma mark - 请求数据
-(void)requestSearchText
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:SearchText parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //捕获异常
        @try {
            for (UIView *suView in [self.view subviews]) {  //移除视图上的空间
                [suView removeFromSuperview];
            }
            NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            //aString = @"sdjfhskhdfdishlsajkdfk";
            NSLog(@"%@", aString);
            NSRange range = [aString rangeOfString:@"=>"];//匹配得到的下标
            aString = [aString substringFromIndex:range.location+range.length];//截取下标 ' 之前的字符串
            range = [aString rangeOfString:@"'"];
            aString = [aString substringFromIndex:range.location+range.length];//截掉下标 ' 之前的字符串
            range = [aString rangeOfString:@"'"];
            aString = [aString substringToIndex:range.location];//截掉下标 ' 之后的字符串
            NSLog(@"截取的值为：%@",aString);
            self.mArry = [[NSArray alloc] init];
            self.mArry = [aString componentsSeparatedByString:@","]; //从字符，中分隔成n个元素的数组
            [self setButtonRandom]; //设置随机button 的位置和颜色
            
            [self setButton];    //加载随机button
        }
        @catch (NSException *exception) {
            NSLog(@"%s\n%@", __FUNCTION__, exception);
            [self.loadingiew removeFromSuperview];
            [self.errorNetwork removeFromSuperview];
            CGRect fr = CGRectMake(self.view.frame.size.width/2.0-300/2.0, self.view.frame.size.height/2.0-300/2.0, 300, 300);
            self.errorNetwork = [loadingImageView setNetWorkError:fr];
            UIButton *but = [self.errorNetwork viewWithTag:7777];
            [but addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.errorNetwork];
        }
        @finally {
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        [self.loadingiew removeFromSuperview];
        CGRect fr = CGRectMake(self.view.frame.size.width/2.0-300/2.0, self.view.frame.size.height/2.0-300/2.0, 300, 300);
        self.errorNetwork = [loadingImageView setNetWorkError:fr];
        UIButton *but = [self.errorNetwork viewWithTag:7777];
        [but addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.errorNetwork];
    }];
}

-(void)buttonAction
{
    [self.errorNetwork removeFromSuperview];
    [self setLoadingView]; //加载加载视图
    [self requestSearchText];
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
