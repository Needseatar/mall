//
//  setAddressTableViewCell.m
//  mall
//
//  Created by Mihua on 26/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "setAddressTableViewCell.h"

@interface setAddressTableViewCell ()

@property (retain, nonatomic) UILabel *addressTitle;
@property (retain, nonatomic) UILabel *mobPhone;
@property (retain, nonatomic) UILabel *addresArea;

@end


@implementation setAddressTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        self.addressTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, delegate.ViewFrame.size.width/2.0-2*5, 30)];
        self.addressTitle.backgroundColor = redColorDebug;
        [self addSubview:self.addressTitle];
        
        self.mobPhone = [[UILabel alloc] initWithFrame:CGRectMake(self.addressTitle.frame.size.width+self.addressTitle.frame.origin.x, 5, delegate.ViewFrame.size.width/2.0, 30)];
        self.mobPhone.backgroundColor = blueColorDebug;
        [self addSubview:self.mobPhone];
        
        self.addresArea = [[UILabel alloc] initWithFrame:CGRectMake(self.addressTitle.frame.origin.x, self.addressTitle.frame.origin.y+self.addressTitle.frame.size.height, delegate.ViewFrame.size.width-2*5, 30)];
        self.addresArea.numberOfLines = 2;
        self.addresArea.backgroundColor = redColorDebug;
        [self addSubview:self.addresArea];
        
        self.backgroundColor = greenColorDebug;
    }
    return self;
}

-(void)setlabelTitle:(addressListModel *)data
{
    self.addressTitle.text = data.true_name;
    self.mobPhone.text = data.mob_phone;
    self.addresArea.text = [NSString stringWithFormat:@"%@ %@", data.area_info, data.address];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
