//
//  UITableView+selectTableView.h
//  mall
//
//  Created by Mihua on 26/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addViewSelectTabelUITableViewCell.h"

@interface UITableView (selectTableView)

//初始化uiview中有view这个视图
+(UIView *)SetSelectTableView:(NSArray *)cellString tabelFram:(CGRect )fr;

//设置cell的重用样式
-(void)cellForRowAtIndexPath:(void(^)(NSIndexPath *indexPath, addViewSelectTabelUITableViewCell *tableViewCell))action;

//返回tabel选择的字体
-(void)didSelectRowAtIndexPath:(void(^)(NSString *selectString))action;

@end
