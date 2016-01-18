//
//  settlementShoppingTableViewCell.m
//  mall
//
//  Created by Mihua on 18/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "settlementShoppingTableViewCell.h"

@interface settlementShoppingTableViewCell ()

@property (retain, nonatomic) UIImageView *bgImageView;


@end

@implementation settlementShoppingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        
        //把image去掉波浪线
        UIImage *img = [UIImage imageNamed:@"shopping_checkout_body_bg.png"];
        CGSize sz = [img size];
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width, sz.height-10), NO, 0);
        [img drawAtPoint:CGPointMake(0, -10)];
        UIImage* BGImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext(); //关闭上下文
        //订单的背景视图
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(orderRightLeftWidth, 0, delegate.ViewFrame.size.width-2*orderRightLeftWidth, 80)];
        [self.bgImageView setImage:BGImg];
        self.bgImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.bgImageView];
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
