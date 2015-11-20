//
//  fiveViewUserTableViewCell.m
//  mall
//
//  Created by Mihua on 20/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fiveViewUserTableViewCell.h"


@interface fiveViewUserTableViewCell ()

@property (strong, nonatomic) UIImageView *bgImage;
@property (strong, nonatomic) UIImageView *userImage;
@property (strong, nonatomic) UIButton    *registeredButton;
@property (strong, nonatomic) UIButton    *signInButton;
@property (strong, nonatomic) UIImageView *attentionImage;
@property (strong, nonatomic) UIImageView *browseImage;
@property (strong, nonatomic) UIImageView *addressImage;
@property (strong, nonatomic) UIImageView *lineImage;
@property (strong, nonatomic) UIImageView *verticalLineImage;


@end

@implementation fiveViewUserTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //背景图片
        self.bgImage = [[UIImageView alloc] initWithFrame:CGRectMakeEx(0, 0, 340, 130)];
        self.bgImage.image = [UIImage imageNamed:@"bg_user_center.jpg"];
        [self addSubview:_bgImage];
        
        //头像
        self.userImage = [[UIImageView alloc] init];
        self.userImage.frame = CGRectMakeEx(15, 30, 60, 60);
        self.userImage.image = [UIImage imageNamed:@"default_user_portrait.gif"];
        self.userImage.layer.masksToBounds = YES;  //告诉layer将位于它之下的layer都遮盖住
        self.userImage.layer.cornerRadius =self.userImage.bounds.size.width*0.5; //设置layer的圆角，刚好是自身宽度的一半，这样就成圆形
        [self addSubview:self.userImage];
        
        //注册
        self.registeredButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.registeredButton.frame = CGRectMakeEx(130, 50, 60, 25);
        self.registeredButton.backgroundColor = [UIColor whiteColor];
        [self.registeredButton setTitle:@"注册" forState:UIControlStateNormal];
        self.registeredButton.titleLabel.textColor = [UIColor whiteColor];
        self.registeredButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.registeredButton];
        
    }
    return self;
}

//-(void)setCellDefault:(int)with height:(int)height
//{
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
