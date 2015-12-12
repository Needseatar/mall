//
//  fourViewController.m
//  Mall
//
//  Created by IOS on 18/11/2015.
//  Copyright © 2015年 IOS. All rights reserved.
//

#import "fourViewController.h"

@interface fourViewController ()<UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *searchBar;

@end

@implementation fourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchBar]; //设置导航栏
    
    [self.view setBackgroundColor:[UIColor blueColor]];
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18],NSFontAttributeName, nil]];
    
    self.title = @"购物车";
    
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
