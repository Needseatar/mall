//
//  settlementOrderTableViewCell.m
//  mall
//
//  Created by Mihua on 18/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "settlementOrderTableViewCell.h"

@interface settlementOrderTableViewCell ()

//@property (retain, nonatomic) UIView      *verticalLine;

@property (retain, nonatomic) UIImageView *bgImageView;
@property (retain, nonatomic) UILabel     *orderLabel;


@end

@implementation settlementOrderTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        //订单的背景视图
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(orderRightLeftWidth, 0, delegate.ViewFrame.size.width-2*orderRightLeftWidth, orderInformationHeight)];
        [self.bgImageView setImage:[UIImage imageNamed:@"shopping_checkout_body_bg.png"]];
        self.bgImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.bgImageView];
        
        //订单详细
        self.orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderTextwidth, 0, delegate.ViewFrame.size.width-2*(orderRightLeftWidth+orderTextwidth), orderInformationHeight)];
        self.orderLabel.text = @"订单明细";
        self.orderLabel.font = [UIFont systemFontOfSize:25];
        [self.bgImageView addSubview:self.orderLabel];
        
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
