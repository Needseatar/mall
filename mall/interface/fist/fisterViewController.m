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
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMakeEx(10, 10, 300, 20)];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
    
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
