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
    }
    return self;
}

-(void)setImage:(dataCommodityInformation *)data
{
    
    NSString *string = data.goods_image;
    NSArray *array = [string componentsSeparatedByString:@","];
    self.scrView.contentSize = CGSizeMakeEx(320*array.count, 250);
    for (int i=0; i<array.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMakeEx(i*320, 0, 320, 250)];
        [imageView setImageWithURL:[NSURL URLWithString:array[i]]];
        [self.scrView addSubview:imageView];
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
