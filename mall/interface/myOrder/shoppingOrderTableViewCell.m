//
//  shoppingOrderTableViewCell.m
//  mall
//
//  Created by Mihua on 23/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "shoppingOrderTableViewCell.h"

#define leftImageHeight 120

@interface shoppingOrderTableViewCell ()

@property (retain, nonatomic) UIImageView *leftImageView;
@property (retain, nonatomic) UILabel     *rightTitlel;
@property (retain, nonatomic) UILabel     *priceLibel;
@property (retain, nonatomic) UILabel     *goodsNumber;

@end

@implementation shoppingOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, leftImageHeight, leftImageHeight)];
        self.leftImageView.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
        [self addSubview:self.leftImageView];
        
        self.rightTitlel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftImageView.frame.origin.x+self.leftImageView.frame.size.width+3, self.leftImageView.frame.origin.y, delegate.ViewFrame.size.width-(self.leftImageView.frame.origin.x+self.leftImageView.frame.size.width+3), 60)];
        self.rightTitlel.numberOfLines = 2;
        self.rightTitlel.backgroundColor = blueColorDebug;
        [self addSubview:self.rightTitlel];
        
        self.priceLibel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftImageView.frame.origin.x+self.leftImageView.frame.size.width+3, self.rightTitlel.frame.size.height+self.rightTitlel.frame.origin.y, self.rightTitlel.frame.size.width, 30)];
        self.priceLibel.backgroundColor = redColorDebug;
        self.priceLibel.textColor = [UIColor redColor];
        [self addSubview:self.priceLibel];
        
        self.goodsNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLibel.frame.origin.x, self.leftImageView.frame.size.height+self.leftImageView.frame.origin.y-30, self.priceLibel.frame.size.width-5, 30)];
        self.goodsNumber.backgroundColor = blueColorDebug;
        self.goodsNumber.textColor = [UIColor grayColor];
        self.goodsNumber.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.goodsNumber];
        
        self.backgroundColor = greenColorDebug;
    }
    return self;
}

-(void)setImageAndText:(extendOrderGoods *)data;
{
    //洗白
    [self.leftImageView setImage:[UIImage imageNamed:@""]];
    
    [self.leftImageView setImageWithURL:[NSURL URLWithString:data.goods_image_url]];
    self.rightTitlel.text = data.goods_name;
    self.priceLibel.text = [NSString stringWithFormat:@"￥%@", data.goods_price];
    self.goodsNumber.text = [NSString stringWithFormat:@"x%@", data.goods_num];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
