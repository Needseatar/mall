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
@property (strong, nonatomic) UILabel     *attentionLabel;
@property (strong, nonatomic) UILabel     *browseLabel;
@property (strong, nonatomic) UILabel     *addressLabel;
@property (strong, nonatomic) UIView      *lineImage;
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
        [self.registeredButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.registeredButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.registeredButton];
        
        //登陆
        self.signInButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.signInButton.frame = CGRectMakeEx(200, 50, 60, 25);
        self.signInButton.backgroundColor = [UIColor whiteColor];
        [self.signInButton setTitle:@"登陆" forState:UIControlStateNormal];
        [self.signInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.signInButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.signInButton];
        
        //竖线
        self.lineImage = [[UIView alloc] init];
        self.lineImage.frame = CGRectMakeEx(0, 100, 340, 2);
        self.lineImage.backgroundColor = [UIColor whiteColor];
        self.lineImage.alpha = 0.2;
        [self addSubview:self.lineImage];
        
        //横线
        self.verticalLineImage = [[UIImageView alloc] init];
        self.verticalLineImage.frame = CGRectMakeEx(0, 100, 340, 30);
        [self.verticalLineImage setImage:[UIImage imageNamed:@"account_tab_bg.png"]];
        [self addSubview:self.verticalLineImage];
        
        //关注的商品
        self.attentionLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 100, 113, 30)];
        [self.attentionLabel setText:@"关注的商品"];
        [self.attentionLabel setTextAlignment:NSTextAlignmentCenter];
        [self.attentionLabel setFont:[UIFont systemFontOfSize:15]];
        [self.attentionLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:self.attentionLabel];
        
        //浏览记录
        self.browseLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(113, 100, 113, 30)];
        [self.browseLabel setText:@"浏览记录"];
        [self.browseLabel setTextAlignment:NSTextAlignmentCenter];
        [self.browseLabel setFont:[UIFont systemFontOfSize:15]];
        [self.browseLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:self.browseLabel];
        
        //地址管理
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(113 * 2, 100, 113, 30)];
        [self.addressLabel setText:@"地址管理"];
        [self.addressLabel setTextAlignment:NSTextAlignmentCenter];
        [self.addressLabel setFont:[UIFont systemFontOfSize:15]];
        [self.addressLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:self.addressLabel];
        
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
