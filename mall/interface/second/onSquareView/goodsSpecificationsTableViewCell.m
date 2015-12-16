//
//  goodsSpecificationsTableViewCell.m
//  mall
//
//  Created by Mihua on 16/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "goodsSpecificationsTableViewCell.h"

@interface goodsSpecificationsTableViewCell ()

@property (retain, nonatomic) UILabel * specificationsLabel;


@end

@implementation goodsSpecificationsTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.specificationsLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(5, 5, 310, 30)];
        self.specificationsLabel.backgroundColor = [UIColor redColor];
        self.specificationsLabel.textColor = [UIColor blackColor];
        [self addSubview:self.specificationsLabel];
        

    }
    return self;
}

-(void)setString:(dataCommodityInformation *)data
{
    //洗白
    self.specificationsLabel.text = @"";
    
    if (data != nil) {
        self.specificationsLabel.text = [NSString stringWithFormat:@"库存:%@", [data.goods_info goods_storage]];
        

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
