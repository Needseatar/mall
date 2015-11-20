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
    // Do any additional setup after loading the view, typically from a nib.
    
    
    fisterViewController * fistView = [[fisterViewController alloc] init];
    UITabBarItem * Item1 = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"main_bottom_tab_home_focus.png"] selectedImage:[UIImage imageNamed:@"main_bottom_tab_home_focus.png"]];
    fistView.tabBarItem = Item1;
    UINavigationController * NfistView = [[UINavigationController alloc] initWithRootViewController:fistView];
    
    
    secondViewController * secondView = [[secondViewController alloc] init];
    UITabBarItem * Item2 = [[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"main_bottom_tab_category_normal.png"] selectedImage:[UIImage imageNamed:@"main_bottom_tab_category_foucus.png"]];
    secondView.tabBarItem = Item2;
    UINavigationController * NsecondView = [[UINavigationController alloc] initWithRootViewController:secondView];
    
    
    thirdViewController * thirdView = [[thirdViewController alloc] init];
    UITabBarItem * Item3 = [[UITabBarItem alloc] initWithTitle:@"搜索" image:[UIImage imageNamed:@"main_bottom_tab_search_normal.png"] selectedImage:[UIImage imageNamed:@"main_bottom_tab_search_focus.png"]];
    thirdView.tabBarItem = Item3;
    UINavigationController * NthirdView = [[UINavigationController alloc] initWithRootViewController:thirdView];
    
    fourViewController * fourView = [[fourViewController alloc] init];
    UITabBarItem * item4 = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"main_bottom_tab_cart_normal.png"] selectedImage:[UIImage imageNamed:@"main_bottom_tab_cart_focus.png"]];
    fourView.tabBarItem = item4;
    UINavigationController * NfourView = [[UINavigationController alloc] initWithRootViewController:fourView];
    
    
    fiveViewController * fiveView = [[fiveViewController alloc] init];
    UITabBarItem * item5 = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"main_bottom_tab_personal_normal.png"] selectedImage:[UIImage imageNamed:@"main_bottom_tab_personal_focus.png"]];
    fiveView.tabBarItem = item5;
    
    
    UITabBarController * tabbarControl = [[UITabBarController alloc] init];
    tabbarControl.viewControllers = @[NfistView, NsecondView, NthirdView, NfourView, fiveView];
    //[tabbarControl.moreNavigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self addChildViewController:tabbarControl];
    [self.view addSubview:tabbarControl.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
