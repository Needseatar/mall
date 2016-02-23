//
//  submitOrderHeadTableViewCell.m
//  mall
//
//  Created by Mihua on 19/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "submitOrderHeadTableViewCell.h"

@interface submitOrderHeadTableViewCell ()

@property (retain, nonatomic) UILabel *storeNameLabel;
@property (retain, nonatomic) UILabel *orderNumberLbael;

@end

@implementation submitOrderHeadTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        self.storeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, delegate.ViewFrame.size.width, 30)];
        self.storeNameLabel.backgroundColor = redColorDebug;
        [self addSubview:self.storeNameLabel];
        
        self.orderNumberLbael = [[UILabel alloc] initWithFrame:CGRectMake(0, self.storeNameLabel.frame.size.height+self.storeNameLabel.frame.origin.y, delegate.ViewFrame.size.width, 30)];
        self.orderNumberLbael.backgroundColor = blueColorDebug;
        [self addSubview:self.orderNumberLbael];
        
        self.backgroundColor = greenColorDebug;
    }
    return self;
}

-(void)setStrigLabel:(dataOrderListModel *)data
{
    self.storeNameLabel.text = [NSString stringWithFormat:@"店铺名称:%@", data.store_name];
    self.orderNumberLbael.text = [NSString stringWithFormat:@"订单编号:%@", data.order_sn];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
