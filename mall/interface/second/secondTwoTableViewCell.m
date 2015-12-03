//
//  secondTwoTableViewCell.m
//  mall
//
//  Created by Mihua on 3/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "secondTwoTableViewCell.h"


@implementation secondTwoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bgLabel = [[UILabel alloc] init];
        self.bgLabel.frame = CGRectMakeEx(0, 0, 220, 35);
        [self.bgLabel setBackgroundColor:[UIColor whiteColor]];
        [self.bgLabel setTextAlignment:NSTextAlignmentLeft];
        [self.bgLabel setTextColor:[UIColor blackColor]];
        [self addSubview:self.bgLabel];
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
