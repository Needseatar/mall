//
//  merchantShopViewController.m
//  mall
//
//  Created by Mihua on 5/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "merchantShopViewController.h"

@interface merchantShopViewController ()



@end

@implementation merchantShopViewController


-(void)viewWillAppear:(BOOL)animated
{
    UISearchBar *searchView = [self.navigationController.navigationBar viewWithTag:30];
    searchView.hidden =  YES;
    self.tabBarController.tabBar.hidden = YES;  //便签控制器隐藏
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]]; //设置返回按钮颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestMerchantShop];
    
    
}

#pragma mark - 全部商家信息
-(void)requestMerchantShop{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer  serializer];
    [manager GET:[NSString stringWithFormat:MerchantShop, self.merchant] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@", dict);
        
        ;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        ;
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
