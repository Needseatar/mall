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
@property (retain, nonatomic) UIButton    *submitOrderButton;

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
        self.bgImageView.userInteractionEnabled = YES;
        [self addSubview:self.bgImageView];
        
        //总额字体
        self.SUMLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderTextwidth, 10, self.bgImageView.frame.size.width-orderTextwidth-110, 30)];
        self.SUMLabel.text = @"总额:";
        self.SUMLabel.font = [UIFont systemFontOfSize:20];
        self.SUMLabel.backgroundColor = [UIColor greenColor];
        [self.bgImageView addSubview:self.SUMLabel];
        
        //总额价格
        self.SUMPaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.SUMLabel.frame.origin.x, self.SUMLabel.frame.origin.y+self.SUMLabel.frame.size.height, self.bgImageView.frame.size.width-orderTextwidth-110, self.SUMLabel.frame.size.height)];
        self.SUMPaceLabel.text = @"￥555.0";
        self.SUMPaceLabel.textColor = [UIColor redColor];
        self.SUMPaceLabel.backgroundColor = [UIColor greenColor];
        [self.bgImageView addSubview:self.SUMPaceLabel];
        
        //提交订单
        self.submitOrderButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.submitOrderButton.frame = CGRectMake(self.bgImageView.frame.size.width-110, 15, 110, 50);
        [self.submitOrderButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [self.submitOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.submitOrderButton setBackgroundColor:[UIColor redColor]];
        self.submitOrderButton.titleLabel.font = [UIFont systemFontOfSize:20];
        self.submitOrderButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.submitOrderButton.userInteractionEnabled = YES;
        [self.submitOrderButton addTarget:self action:@selector(submitOrder) forControlEvents:UIControlEventTouchUpInside];
        [self.bgImageView addSubview:self.submitOrderButton];
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}



-(void)submitOrder
{
    ;
    ;
    ;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
