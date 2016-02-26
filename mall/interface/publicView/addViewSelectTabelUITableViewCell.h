//
//  addViewSelectTabelUITableViewCell.h
//  mall
//
//  Created by Mihua on 26/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addViewSelectTabelUITableViewCell : UITableViewCell

@property (retain, nonatomic) UILabel *titleLabel; //设置字体的颜色样式
@property (retain, nonatomic) UIView  *lineView; //设置间隔线的颜色样式

-(void)setStringFram:(NSString *)cellString fram:(CGRect)cellFram;

@end
