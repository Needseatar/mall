//
//  downSettlementTableViewCell.m
//  mall
//
//  Created by Mihua on 18/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "downSettlementTableViewCell.h"

@interface downSettlementTableViewCell ()

@property (retain, nonatomic) UIImageView *bgImageView;
@property (retain, nonatomic) UILabel     *SUMLabel;
@property (retain, nonatomic) UILabel     *SUMPaceLabel;

@end


@implementation downSettlementTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        
        //订单的背景视图
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(orderRightLeftWidth, 0, delegate.ViewFrame.size.width-2*orderRightLeftWidth, 80)];
        UIImage *img = [UIImage imageNamed:@"shopping_cart_body_bg.png"];
        [self.bgImageView setImage:img];
        self.bgImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.bgImageView];
        
        //总额字体
        self.SUMLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderRightLeftWidth+10, 20, 60, 40)];
        self.SUMLabel;
        
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
