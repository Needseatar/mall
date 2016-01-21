//
//  fisterHome4TableViewCell.m
//  mall
//
//  Created by Mihua on 22/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterHome4TableViewCell.h"


@interface fisterHome4TableViewCell ()

@property (retain, nonatomic) UIImageView *leftUpImage;
@property (retain, nonatomic) UIImageView *leftdownImage;
@property (retain, nonatomic) UIImageView *rightImage;
@property (retain, nonatomic) fisterHome4 *data;

@end

@implementation fisterHome4TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftUpImage = [[UIImageView alloc] initWithFrame:CGRectMakeEx(0, 3, 320/2, 75)];
        self.leftUpImage.tag = 10;
        UITapGestureRecognizer * attentionTapAction1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attentionAction:)];//加载点击动作
        [self.leftUpImage addGestureRecognizer:attentionTapAction1];
        self.leftUpImage.userInteractionEnabled = YES;
        [self addSubview:self.leftUpImage];
        
        self.leftdownImage = [[UIImageView alloc] initWithFrame:CGRectMakeEx(0, 75+3, 320/2, 75)];
        self.leftdownImage.tag = 11;
        UITapGestureRecognizer * attentionTapAction2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attentionAction:)];//加载点击动作
        [self.leftdownImage addGestureRecognizer:attentionTapAction2];
        self.leftdownImage.userInteractionEnabled = YES;
        [self addSubview:self.leftdownImage];
        
        self.rightImage = [[UIImageView alloc] initWithFrame:CGRectMakeEx(320/2, 3, 320/2, 150)];
        self.rightImage.tag = 12;
        UITapGestureRecognizer * attentionTapAction3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attentionAction:)];//加载点击动作
        [self.rightImage addGestureRecognizer:attentionTapAction3];
        self.rightImage.userInteractionEnabled = YES;
        [self addSubview:self.rightImage];
    }
    return self;
}

-(void)setTextAndImage:(fisterHome4 *)homeData
{
    self.data = homeData;
    //洗白
    [self.leftUpImage setImage:[UIImage imageNamed:@""]];
    [self.leftdownImage setImage:[UIImage imageNamed:@""]];
    [self.rightImage setImage:[UIImage imageNamed:@""]];
    
    [self.leftUpImage setImageWithURL:[NSURL URLWithString:homeData.rectangle1_image]];
    [self.leftdownImage setImageWithURL:[NSURL URLWithString:homeData.rectangle2_image]];
    [self.rightImage setImageWithURL:[NSURL URLWithString:homeData.square_image]];
}

-(void)attentionAction:(UITapGestureRecognizer *)tap
{
    NSString *str = [[NSString alloc] init];
    NSRange range;
    if (tap.view.tag ==10) {
        NSString *url = [NSString stringWithFormat:@"%@", self.data.rectangle1_type];
        if ([url isEqualToString:@"url"] && [str rangeOfString:@"goods_id"].location != NSNotFound) {
            
            range = [self.data.rectangle1_data rangeOfString:@"goods_id"];
            str = [self.data.rectangle1_data substringFromIndex:(range.location+range.length)];
            range = [str rangeOfString:@"="];
            str = [str substringFromIndex:(range.location+range.length)];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Home4" object:str];
        }
    }else if (tap.view.tag ==11)
    {
        NSString *url = [NSString stringWithFormat:@"%@", self.data.rectangle2_type];
        if ([url isEqualToString:@"url"] && [str rangeOfString:@"goods_id"].location != NSNotFound) {
            range = [self.data.rectangle2_data rangeOfString:@"goods_id"];
            str = [self.data.rectangle2_data substringFromIndex:(range.location+range.length)];
            range = [str rangeOfString:@"="];
            str = [str substringFromIndex:(range.location+range.length)];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Home4" object:str];
        }
    }else if (tap.view.tag == 12)
    {
        NSString *url = [NSString stringWithFormat:@"%@", self.data.square_type];
        if ([url isEqualToString:@"url"] && [str rangeOfString:@"goods_id"].location != NSNotFound) {
            range = [self.data.square_data rangeOfString:@"goods_id"];
            str = [self.data.square_data substringFromIndex:(range.location+range.length)];
            range = [str rangeOfString:@"="];
            str = [str substringFromIndex:(range.location+range.length)];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Home4" object:str];
        }
    }

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
