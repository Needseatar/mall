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

@end

@implementation fisterHome4TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftUpImage = [[UIImageView alloc] initWithFrame:CGRectMakeEx(0, 3, 320/2, 75)];
        self.leftUpImage.backgroundColor = [UIColor clearColor];
        [self addSubview:self.leftUpImage];
        
        self.leftdownImage = [[UIImageView alloc] initWithFrame:CGRectMakeEx(0, 75+3, 320/2, 75)];
        self.leftdownImage.backgroundColor = [UIColor clearColor];
        [self addSubview:self.leftdownImage];
        
        self.rightImage = [[UIImageView alloc] initWithFrame:CGRectMakeEx(320/2, 3, 320/2, 150)];
        self.rightImage.backgroundColor = [UIColor clearColor];
        [self addSubview:self.rightImage];
    }
    return self;
}

-(void)setTextAndImage:(fisterHome4 *)homeData
{
    //洗白
    [self.leftUpImage setImage:[UIImage imageNamed:@""]];
    [self.leftdownImage setImage:[UIImage imageNamed:@""]];
    [self.rightImage setImage:[UIImage imageNamed:@""]];
    
    [self.leftUpImage setImageWithURL:[NSURL URLWithString:homeData.rectangle1_image]];
    [self.leftdownImage setImageWithURL:[NSURL URLWithString:homeData.rectangle2_image]];
    [self.rightImage setImageWithURL:[NSURL URLWithString:homeData.square_image]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
