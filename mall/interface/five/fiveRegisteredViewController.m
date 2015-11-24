//
//  fiveRegisteredViewController.m
//  mall
//
//  Created by Mihua on 24/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fiveRegisteredViewController.h"

@interface fiveRegisteredViewController ()

@end


@implementation fiveRegisteredViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO; //隐藏导航控制器
    
    self.tabBarController.tabBar.hidden =  YES;  //便签控制器不隐藏
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    [self.view setBackgroundColor:[UIColor whiteColor]];
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
