//
//  secondMainTableViewCell.m
//  mall
//
//  Created by Mihua on 1/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "secondMainTableViewCell.h"


@implementation secondMainTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bgLabel = [[UILabel alloc] init];
        self.bgLabel.frame = CGRectMakeEx(0, 0, 100, 35);
        [self.bgLabel setBackgroundColor:[UIColor grayColor]];
        [self.bgLabel setTextAlignment:NSTextAlignmentCenter];
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
