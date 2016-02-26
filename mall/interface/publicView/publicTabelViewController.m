//
//  publicTabelViewController.m
//  mall
//
//  Created by Mihua on 26/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "publicTabelViewController.h"

@interface publicTabelViewController ()

@property (retain, nonatomic) UIImage *bgImage;

@end

@implementation publicTabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *vddd = [[UIImageView alloc] initWithFrame:self.view.frame];
    [vddd setImage:self.bgImage];
    [self.view addSubview:vddd];
    
    UIButton *ddd = [UIButton buttonWithType:UIButtonTypeCustom];
    ddd.frame = CGRectMake(10, 10, 100, 100);
    ddd.backgroundColor = [UIColor greenColor];
    [ddd addTarget:self action:@selector(dfsafsdf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ddd];
}
-(void)dfsafsdf
{
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)screenshot
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.bgImage = viewImage;
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
