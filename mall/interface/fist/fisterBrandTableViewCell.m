//
//  fisterBrandTableViewCell.m
//  mall
//
//  Created by Mihua on 21/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterBrandTableViewCell.h"

@implementation fisterBrandTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSArray *iconNameArray = @[@"nav_1.png", @"nav_2.png", @"nav_3.png", @"nav_4.png",
                                   @"nav_5.png", @"nav_6.png", @"nav_7.png", @"nav_8.png"];
        NSArray *nameArray = @[@"万能居", @"泰润酒店", @"大浪淘沙酒店", @"战略联盟商家",
                               @"所有店铺", @"所有商品", @"帮助中心", @"反馈留言"];
        for (int i=0; i<8; i++) {
            UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
            but.frame = CGRectMakeEx((i%4)*76+10, (i/4)*60+10, 75, 60);
            [but setBackgroundColor:[UIColor clearColor]];
            [but addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            but.tag = 20+i;
            [self addSubview:but];
            
            UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMakeEx(75/2-40/2, 0, 40, 40)];
            iconImageView.image = [UIImage imageNamed:iconNameArray[i]];
            [but addSubview:iconImageView];
            
            UILabel *iconlabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 40, 75, 20)];
            iconlabel.backgroundColor = [UIColor clearColor];
            iconlabel.textAlignment = NSTextAlignmentCenter;
            iconlabel.font = [UIFont systemFontOfSize:12];
            iconlabel.text = nameArray[i];
            [but addSubview:iconlabel];
        }
    }
    return self;
}

-(void)buttonAction:(UIButton *)but
{
    NSArray *nameArray = @[@"万能居", @"泰润酒店", @"大浪淘沙酒店", @"战略联盟商家",
                           @"所有店铺", @"所有商品", @"帮助中心", @"反馈留言"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"function" object:nameArray[but.tag-20]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
