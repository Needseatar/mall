//
//  goodInformationViewController.m
//  mall
//
//  Created by Mihua on 11/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "goodInformationViewController.h"

@interface goodInformationViewController ()

@property (retain, nonatomic) UIView         *bgSortView;
@property (retain, nonatomic) NSArray        *InformatonItem;     //排序导航栏下面的排序标题

@property (retain, nonatomic) UIView         *redLine;

@end

@implementation goodInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self commodityInformatonItem];
}


-(void)commodityInformatonItem
{
    self.bgSortView = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 64, 320, 30)];
    [self.bgSortView setBackgroundColor:[UIColor colorWithRed:248.0/255.0f green:249.0/255.0f blue:250.0/255.0f alpha:1]];
    [self.view addSubview:self.bgSortView];
    
    self.InformatonItem = @[@"商品详情", @"图文详情", @"商品评论"];
    for (int i=0; i<self.InformatonItem.count; i++) {
        UIButton *sortBut = [[UIButton alloc] initWithFrame:CGRectMakeEx(i*320/self.InformatonItem.count, 0, 320/self.InformatonItem.count, 30)];
        if (i==0) {
            sortBut.selected = NO;
        }else
        {
            sortBut.selected = YES;
        }
        [sortBut setTitle:self.InformatonItem[i] forState:UIControlStateNormal];
        [sortBut setTitle:self.InformatonItem[i] forState:UIControlStateSelected];
        [sortBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [sortBut setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        sortBut.titleLabel.textAlignment = NSTextAlignmentCenter;
        sortBut.tag = i+300;
        [sortBut addTarget:self action:@selector(buttonSetAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgSortView addSubview:sortBut];
        
        if (i!=0 || i!=self.InformatonItem.count) {
            //中间的两条线
            UIView *bgVerticalLine = [[UIView alloc] initWithFrame:CGRectMakeEx(i*320/self.InformatonItem.count-1, 5, 2, 20)];
            bgVerticalLine.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
            [self.bgSortView addSubview:bgVerticalLine];
        }
    }
    
    //下面的背景横线
    UIView *bgLine = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 94, 320, 2)];
    bgLine.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
    [self.view addSubview:bgLine];
    
    //加载背景横线上面的红色视图
    self.redLine = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 92, 320/self.InformatonItem.count, 4)];
    self.redLine.backgroundColor = [UIColor redColor];
    self.redLine.alpha = 0.4;
    [self.view addSubview:self.redLine];
}

-(void)buttonSetAction:(UIButton *)but{
    for (int i=0; i<300; i++) {
        UIButton *yesBut = [self.bgSortView viewWithTag:i+300];
        yesBut.selected = YES;
    }
    
    but.selected = NO; //选择的哪一个button
    
    //平移动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    // 动画持续1秒
    anim.duration =1;
    //因为CGPoint是结构体，所以用NSValue包装成一个OC对象
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    //通过MyAnim可以取回相应的动画对象，比如用来中途取消动画
    [self.redLine.layer addAnimation:anim forKey:@"MyAnim"];
    
    //[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(redViewAction) userInfo:nil repeats:100];
}
//-(void)redViewAction
//{
//    for (int i=0; i<300; i++) {
//        UIButton *yesBut = [self.bgSortView viewWithTag:i+300];
//        if (yesBut == NO) {
//            if (self.redLine.frame.origin.x != yesBut.frame.origin.x) {
//                if (self.redLine.frame.origin.x > yesBut.frame.origin.x) {
//                    int i = self.redLine.frame.origin.x;
//                }else
//                {
//                    self.redLine.frame.origin.x = self.redLine.frame.origin.x+1;
//                }
//            }
//        }
//    }
//}


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
