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

@property (retain, nonatomic) UIImageView *goodsImageView;
@property (retain, nonatomic) UILabel     *goodsTitleLabel;
@property (retain, nonatomic) UILabel     *goodsPaceLabel;
@property (retain, nonatomic) UILabel     *goodsNumberLabel;


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
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(orderRightLeftWidth, 0, delegate.ViewFrame.size.width-2*orderRightLeftWidth, orderGoodsCellHeight)];
        [self.bgImageView setImage:BGImg];
        self.bgImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.bgImageView];
        
        //上边的分隔线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, 0, self.bgImageView.frame.size.width-2*orderTextwidth, 1)];
        line.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
        [self.bgImageView addSubview:line];
        
        //左边的图片
        self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(orderTextwidth, 5, orderGoodsCellHeight-10, orderGoodsCellHeight-10)];
        self.goodsImageView.backgroundColor = redColorDebug;
        [self.bgImageView addSubview:self.goodsImageView];
        
        //标题
        self.goodsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodsImageView.frame.origin.x+self.goodsImageView.frame.size.width+5, 3, self.bgImageView.frame.size.width-(self.goodsImageView.frame.origin.x+self.goodsImageView.frame.size.width+5)-orderTextwidth, 60)];
        self.goodsTitleLabel.numberOfLines = 3;
        self.goodsTitleLabel.font = [UIFont systemFontOfSize:16];
        self.goodsTitleLabel.backgroundColor = greenColorDebug;
        [self.bgImageView addSubview:self.goodsTitleLabel];
        
        //价格
        self.goodsPaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodsTitleLabel.frame.origin.x, self.goodsTitleLabel.frame.origin.y+self.goodsTitleLabel.frame.size.height, self.goodsTitleLabel.frame.size.width, 25)];
        self.goodsPaceLabel.textColor = [UIColor redColor];
        self.goodsPaceLabel.backgroundColor = blueColorDebug;
        [self.bgImageView addSubview:self.goodsPaceLabel];
        
        self.goodsNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodsPaceLabel.frame.origin.x, self.goodsPaceLabel.frame.origin.y+self.goodsPaceLabel.frame.size.height, self.goodsPaceLabel.frame.size.width, 25)];
        self.goodsNumberLabel.backgroundColor = redColorDebug;
        [self.bgImageView addSubview:self.goodsNumberLabel];
        
    }
    return self;
}


-(void)setGoodsImageTitle:(storeCartGoodsList *)data
{
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:data.goods_image_url]];
    
    self.goodsTitleLabel.text = data.goods_name;
    
    self.goodsPaceLabel.text = [NSString stringWithFormat:@"单价(￥%@元)", data.goods_price];
    
    self.goodsNumberLabel.text = [NSString stringWithFormat:@"数量:%@", data.goods_num];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
