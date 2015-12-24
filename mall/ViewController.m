//
//  ViewController.m
//  mall
//
//  Created by Mihua on 19/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    fisterViewController * fistView = [[fisterViewController alloc] init];
    UIImage * normalImage1 = [[UIImage imageNamed:@"main_bottom_tab_home_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage1 = [[UIImage imageNamed:@"main_bottom_tab_home_focus.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * item1 = [[UITabBarItem alloc]initWithTitle:@"首页" image:normalImage1 selectedImage:selectImage1];
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal]; //设置没有选择字体颜色
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];//设置选中字体颜色
    fistView.tabBarItem = item1;
    UINavigationController * NfistView = [[UINavigationController alloc] initWithRootViewController:fistView];
    
    secondViewController * secondView = [[secondViewController alloc] init];
    UIImage * normalImage2 = [[UIImage imageNamed:@"main_bottom_tab_category_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage2 = [[UIImage imageNamed:@"main_bottom_tab_category_focus.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * item2 = [[UITabBarItem alloc]initWithTitle:@"分类" image:normalImage2 selectedImage:selectImage2];
    [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal]; //设置没有选择字体颜色
    [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];//设置选中字体颜色
    secondView.tabBarItem = item2;
    UINavigationController * NsecondView = [[UINavigationController alloc] initWithRootViewController:secondView];
    
    
    thirdViewController * thirdView = [[thirdViewController alloc] init];
    UIImage * normalImage3 = [[UIImage imageNamed:@"main_bottom_tab_search_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage3 = [[UIImage imageNamed:@"main_bottom_tab_search_focus.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * item3 = [[UITabBarItem alloc]initWithTitle:@"搜索" image:normalImage3 selectedImage:selectImage3];
    [item3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal]; //设置没有选择字体颜色
    [item3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];//设置选中字体颜色
    thirdView.tabBarItem = item3;
    UINavigationController * NthirdView = [[UINavigationController alloc] initWithRootViewController:thirdView];
    
    fourViewController * fourView = [[fourViewController alloc] init];
    UIImage * normalImage4 = [[UIImage imageNamed:@"main_bottom_tab_cart_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage4 = [[UIImage imageNamed:@"main_bottom_tab_cart_focus.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * item4 = [[UITabBarItem alloc]initWithTitle:@"购物车" image:normalImage4 selectedImage:selectImage4];
    [item4 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal]; //设置没有选择字体颜色
    [item4 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];//设置选中字体颜色
    fourView.tabBarItem = item4;
    fourView.title = @"购物车";
    UINavigationController * NfourView = [[UINavigationController alloc] initWithRootViewController:fourView];
    
    
    fiveViewController * fiveView = [[fiveViewController alloc] init];
    UIImage * normalImage5 = [[UIImage imageNamed:@"main_bottom_tab_personal_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage5 = [[UIImage imageNamed:@"main_bottom_tab_personal_focus.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * item5 = [[UITabBarItem alloc]initWithTitle:@"我" image:normalImage5 selectedImage:selectImage5];
    [item5 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal]; //设置没有选择字体颜色
    [item5 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];//设置选中字体颜色
    fiveView.tabBarItem = item5;
    fiveView.title = @"我";
    UINavigationController * NfiveView = [[UINavigationController alloc] initWithRootViewController:fiveView];
    
    
    UITabBarController * tabbarControl = [[UITabBarController alloc] init];
    tabbarControl.viewControllers = @[NfistView, NsecondView, NthirdView, NfourView, NfiveView];
    [tabbarControl.tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    [tabbarControl.tabBarController.tabBar setAlpha:1];
    [self addChildViewController:tabbarControl];
    [self.view addSubview:tabbarControl.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
