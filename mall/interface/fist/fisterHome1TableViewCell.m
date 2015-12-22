//
//  fisterHome1TableViewCell.m
//  mall
//
//  Created by Mihua on 21/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterHome1TableViewCell.h"

@interface fisterHome1TableViewCell ()

@property (retain, nonatomic) UILabel     *titleLabel;
@property (retain, nonatomic) UIImageView *shoppingView;

@end

@implementation fisterHome1TableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        
        self.shoppingView = [[UIImageView alloc] init];
        self.shoppingView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.shoppingView];
    }
    return self;
}

-(void)setTextAndImage:(fisterHome1 *)homeData;
{
    //洗白
    self.titleLabel.text = @"";
    self.titleLabel.frame = CGRectMakeEx(0, 3, 320, 30);
    [self.shoppingView setImage:[UIImage imageNamed:@""]];
    self.shoppingView.frame = CGRectMakeEx(0, 30+3, 320, 150);
    
    if (homeData.title.length == 0) {
        self.titleLabel.hidden = YES;
        self.shoppingView.frame = CGRectMakeEx(0, 3, 320, 150);
    }else
    {
        self.titleLabel.text = [NSString stringWithFormat:@" %@", homeData.title];
    }
    [self.shoppingView setImageWithURL:[NSURL URLWithString:homeData.image]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
