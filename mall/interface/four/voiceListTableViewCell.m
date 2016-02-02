//
//  voiceListTableViewCell.m
//  mall
//
//  Created by Mihua on 1/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "voiceListTableViewCell.h"

@interface voiceListTableViewCell ()

@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UILabel *detailsLabel;

@end

@implementation voiceListTableViewCell

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
//        
//        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, , , )];
//    }
//    return self;
//}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
