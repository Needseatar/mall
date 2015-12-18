//
//  goodInformationTableViewCell.m
//  mall
//
//  Created by Mihua on 14/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "goodInformationTableViewCell.h"

@interface goodInformationTableViewCell ()

@property (retain, nonatomic) UIScrollView *scrView;

@property (retain, nonatomic) UILabel      *downLabel;

@end

@implementation goodInformationTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //背景滚动视图
        self.scrView = [[UIScrollView alloc] initWithFrame:CGRectMakeEx(0, 0, 320, 250)];
        [self.scrView setBackgroundColor:[UIColor whiteColor]];
        self.scrView.pagingEnabled = YES;
        [self addSubview:self.scrView];
        
        //标题
        self.downLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(5, 250, 310, 30)];
        self.downLabel.numberOfLines = 0;
        self.downLabel.font = [UIFont systemFontOfSize:18];
        self.downLabel.backgroundColor = [UIColor clearColor];
        self.downLabel.textColor = [UIColor blackColor];
        [self addSubview:self.downLabel];
    }
    return self;
}

-(void)setImage:(dataCommodityInformation *)data
{
    NSString *string = data.goods_image;
    NSArray *array = [string componentsSeparatedByString:@","];
    
    //洗白
    for (int i=0; i<array.count; i++) {
        UIImageView *imageView = [self.scrView viewWithTag:30+i];
        [imageView setImage:[UIImage imageNamed:@""]];
    }
    self.downLabel.text = @"";
    
    //加载第一组视图图片
    self.scrView.contentSize = CGSizeMakeEx(320*array.count, 250);
    for (int i=0; i<array.count; i++) {
        UIImageView *imageView = [self.scrView viewWithTag:30+i];
        if (imageView == nil) {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMakeEx(i*320, 0, 320, 250)];
            imageView.tag = 30;
        }
        [imageView setImageWithURL:[NSURL URLWithString:array[i]]];
        [self.scrView addSubview:imageView];
    }
    
    
    //加载下面的文字
    secondGoodsInfo *GInfo = data.goods_info;
    self.downLabel.text = GInfo.goods_name;
    //计算label高度
    CGRect frame = self.downLabel.frame;
    frame.size.height = heightEx([self heightWithString:self.downLabel.text width:310 fontSize:18]);
    self.downLabel.frame = frame;
    
}

#pragma mark - 计算label高度
-(CGFloat)heightWithString:(NSString *)string width:(CGFloat)width fontSize:(CGFloat)fontSize
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize + 1.5]} context:nil];
    
    return heightEx(rect.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
