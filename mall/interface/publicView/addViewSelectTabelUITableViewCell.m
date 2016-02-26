//
//  addViewSelectTabelUITableViewCell.m
//  mall
//
//  Created by Mihua on 26/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "addViewSelectTabelUITableViewCell.h"

@implementation addViewSelectTabelUITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
        [self addSubview:self.lineView];
    }
    return self;
}

-(void)setStringFram:(NSString *)cellString fram:(CGRect)cellFram
{
    self.titleLabel.frame = CGRectMake(0, 0, cellFram.size.width, cellFram.size.height-1);
    self.titleLabel.text = cellString;
    
    self.titleLabel.frame = CGRectMake(0, self.titleLabel.frame.size.height, cellFram.size.width, 1);
}
@end
