//
//  thirdViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//

#import "thirdViewController.h"

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
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMakeEx(20, 7, 240, 20)];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
    
    //右边搜索按钮
    UIButton * rightCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightCamera setTitle:@"搜索" forState:UIControlStateNormal];
    [rightCamera setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //rightCamera.titleLabel.font = [UIFont systemFontOfSize:18];
    //rightCamera.titleLabel.backgroundColor = [UIColor blueColor];
    rightCamera.frame = CGRectMakeEx(0, 0, 45, 25);
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
