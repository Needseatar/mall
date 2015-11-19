//
//  fisterViewController.m
//  mall
//
//  Created by Mihua on 19/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterViewController.h"
#import "ZJScreenAdaptation.h"

@interface fisterViewController ()<UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar * searchBar;

@end

@implementation fisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createSearchBar]; //设置导航栏
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], [UIColor blueColor],nil]];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMakeEx(65, 7, 200, 20)];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
    
    //左边logo
    UIButton * leftLogo = [UIButton buttonWithType:UIButtonTypeCustom];
    leftLogo.frame = CGRectMakeEx(0, 0, 40,20);
    [leftLogo setImage:[UIImage imageNamed:@"home_logo.9.png"] forState:UIControlStateNormal];
    UIBarButtonItem * leftLogoItem = [[UIBarButtonItem alloc] initWithCustomView:leftLogo];
    self.navigationItem.leftBarButtonItem = leftLogoItem;
    
    //右边二维码
    UIButton * rightCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    rightCamera.frame = CGRectMakeEx(0, 0, 20,20);
    [rightCamera setImage:[UIImage imageNamed:@"barcode_normal.png"] forState:UIControlStateNormal];
    UIBarButtonItem * rightCameraItem = [[UIBarButtonItem alloc] initWithCustomView:rightCamera];
    self.navigationItem.rightBarButtonItem = rightCameraItem;

    
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
