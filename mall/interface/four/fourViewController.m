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
    
    [self setNotGoodsView];  //设置没有登录时候界面
    
    [self.view setBackgroundColor:[UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1]];
}

#pragma mark - 设置导航栏的搜索和取消
-(void)createSearchBar{
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0f green:118.0/255.0f blue:118.0/255.0f alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18],NSFontAttributeName, nil]];
    
    self.title = @"购物车";
    
}

-(void)setNotGoodsView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMakeEx(5, 10, 310, 20)];
    label.text = @"你可以在登录系统后同步电脑与手机购物车中的商品";
    label.font = [UIFont systemFontOfSize:10];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
    UIView *bgGoodsView = [[UIView alloc] initWithFrame:CGRectMakeEx(5, 40, 310, 160)];
    bgGoodsView.backgroundColor = [UIColor whiteColor];
    bgGoodsView.layer.masksToBounds = YES;  //告诉layer将位于它之下的layer都遮盖住
    bgGoodsView.layer.cornerRadius =3;
    bgGoodsView.layer.borderWidth = 1;//边框宽度
    bgGoodsView.layer.borderColor = [[UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1] CGColor];//边框颜色
    [self.view addSubview:bgGoodsView];
    
    UIImageView *ShoppingCart = [[UIImageView alloc] initWithFrame:CGRectMakeEx(310/2-50, 20, 100, 100)];
    ShoppingCart.image = [UIImage imageNamed:@"cart.png"];
    [bgGoodsView addSubview:ShoppingCart];
    
    UILabel *shoppingLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 120, 310, 30)];
    shoppingLabel.text = @"你的购物车是空的，快去选购吧！";
    shoppingLabel.textAlignment = NSTextAlignmentCenter;
    shoppingLabel.font = [UIFont systemFontOfSize:13];
    shoppingLabel.backgroundColor = [UIColor clearColor];
    [bgGoodsView addSubview:shoppingLabel];
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
