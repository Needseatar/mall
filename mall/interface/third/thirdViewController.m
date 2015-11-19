//
//  thirdViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//

#import "thirdViewController.h"
#import "ZJScreenAdaptation.h"

@interface thirdViewController ()<UISearchBarDelegate>

@property (nonatomic, strong)UISearchBar *searchBar;

@end

@implementation thirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchBar];  //设置导航栏
    
    [self.view setBackgroundColor:[UIColor greenColor]];
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], [UIColor blueColor],nil]];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMakeEx(20, 7, 240, 20)];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
    
    //右边二维码
    UIButton * rightCamera = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightCamera setTitle:@"搜索" forState:UIControlStateNormal];
    [rightCamera setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightCamera.titleLabel.font = [UIFont systemFontOfSize:18];
    rightCamera.frame = CGRectMakeEx(0, 0, 35, 20);
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
