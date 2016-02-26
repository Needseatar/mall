//
//  UITableView+selectTableView.m
//  mall
//
//  Created by Mihua on 26/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "UITableView+selectTableView.h"

@implementation UITableView (selectTableView)


#pragma mark - 初始化uiview中有view这个视图
+(UIView *)SetSelectTableView:(NSArray *)cellString tabelFram:(CGRect )fr
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSArray *array = cellString;
    NSLog(@"%@", array[0]);
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, delegate.ViewFrame.size.width, delegate.ViewFrame.size.height)];
    vi.backgroundColor = [UIColor blackColor];
    vi.alpha = 0.5;
    
    
    return vi;
}

#pragma mark - 设置cell的重用样式
-(void)cellForRowAtIndexPath:(void(^)(NSIndexPath *indexPath, addViewSelectTabelUITableViewCell *tableViewCell))action
{
    
}

#pragma mark - 返回tabel选择的字体
-(void)didSelectRowAtIndexPath:(void(^)(NSString *selectString))action
{
    
}


@end
