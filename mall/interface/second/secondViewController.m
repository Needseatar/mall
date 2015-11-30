//
//  secondViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//

#import "secondViewController.h"

@interface secondViewController ()<UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar       *searchBar;
@property (retain, nonatomic) NSArray           *OCassification;

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchBar];   //设置导航栏的搜索和取消
    
    [self setTabelView];  //加载table一级分类tabel
    
    [self requestClassification]; //请求一级数据
    
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    [self.view setBackgroundColor:[UIColor brownColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMakeEx(20, 7, 260, 20)];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
    
    //右边二维码
    UIButton * rightCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    rightCamera.frame = CGRectMakeEx(0, 0, 20,20);
    [rightCamera setImage:[UIImage imageNamed:@"barcode_normal.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightCameraItem = [[UIBarButtonItem alloc] initWithCustomView:rightCamera];
    self.navigationItem.rightBarButtonItem = rightCameraItem;
    
}
#pragma mark - 加载tabel
-(void)setTabelView
{
    ;
}
#pragma mark - 请求数据
-(void)requestClassification
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:FisterClassification parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        self.OCassification = [oneClassification setValueWithDictionary:dict];
        NSLog(@"%@", [self.OCassification[0] gc_name]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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
