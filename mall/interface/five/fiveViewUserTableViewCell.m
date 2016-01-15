//
//  fiveViewUserTableViewCell.m
//  mall
//
//  Created by Mihua on 20/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fiveViewUserTableViewCell.h"


@interface fiveViewUserTableViewCell ()

@property (retain, nonatomic) UIImageView *bgImage;
@property (retain, nonatomic) UIView      *lineImage;
@property (retain, nonatomic) UIImageView *verticalLineImage;
@property (retain, nonatomic) UIImageView *userImage;          //设置头像
@property (retain, nonatomic) UIButton    *registeredButton; //设置登陆
@property (retain, nonatomic) UIButton    *signInButton;    //设置注册
@property (retain, nonatomic) UILabel     *attentionLabel;  //设置关注的商品
@property (retain, nonatomic) UILabel     *browseLabel;   //设置浏览记录
@property (retain, nonatomic) UILabel     *addressLabel; //设置地址管理

@property (retain, nonatomic) UIView      *bgSignInView; //登陆时候背景视图

@property (strong, nonatomic) fiveBlockString *string; //返回需要调用函数的字符

@property (retain, nonatomic) UIView      *bgUserView;
@property (retain, nonatomic) UILabel     *userNamelabel;
@property (retain, nonatomic) UILabel     *userPointLabel;
@property (retain, nonatomic) UILabel     *predepoitLabel;



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
        UITapGestureRecognizer * userTapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userAction)];//加载点击动作
        [self.userImage addGestureRecognizer:userTapAction];
        self.userImage.userInteractionEnabled = YES;
        [self addSubview:self.userImage];
        
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
        UITapGestureRecognizer * attentionTapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attentionAction)];//加载点击动作
        [self.attentionLabel addGestureRecognizer:attentionTapAction];
        self.attentionLabel.userInteractionEnabled = YES;
        [self addSubview:self.attentionLabel];
        
        //浏览记录
        self.browseLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(113, 100, 113, 30)];
        [self.browseLabel setText:@"浏览记录"];
        [self.browseLabel setTextAlignment:NSTextAlignmentCenter];
        [self.browseLabel setFont:[UIFont systemFontOfSize:15]];
        [self.browseLabel setTextColor:[UIColor whiteColor]];
        UITapGestureRecognizer * browseTapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(browseAction)];//加载点击动作
        [self.browseLabel addGestureRecognizer:browseTapAction];
        self.browseLabel.userInteractionEnabled = YES;
        [self addSubview:self.browseLabel];
        
        //地址管理
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(113 * 2, 100, 113, 30)];
        [self.addressLabel setText:@"地址管理"];
        [self.addressLabel setTextAlignment:NSTextAlignmentCenter];
        [self.addressLabel setFont:[UIFont systemFontOfSize:15]];
        [self.addressLabel setTextColor:[UIColor whiteColor]];
        UITapGestureRecognizer * addressTapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressAction)];//加载点击动作
        [self.addressLabel addGestureRecognizer:addressTapAction];
        self.addressLabel.userInteractionEnabled = YES;
        [self addSubview:self.addressLabel];
        
    }
    return self;
}

-(void)setButtonAndUser:(signInModel *)signInUser
             userMyMall:(fiveMyMallmodel *)userMyMall
{
    if (signInUser.whetherSignIn == YES) { //判断是否登录，登录了就关闭按钮，加载用户信息
        [self.registeredButton removeFromSuperview];
        [self.signInButton removeFromSuperview];
        self.registeredButton = nil;
        self.signInButton = nil;
        if (self.bgUserView == nil) { //判断是否已经初始化了
            //用户资料背景图
            self.bgUserView = [[UIView alloc] initWithFrame:CGRectMakeEx(85, 35, 140, 60)];
            self.bgUserView.backgroundColor = [UIColor clearColor];
            [self addSubview:self.bgUserView];
            
            self.userNamelabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 0, 140, 15)];
            self.userNamelabel.textColor = [UIColor whiteColor];
            self.userNamelabel.backgroundColor = [UIColor clearColor];
            
            [self.bgUserView addSubview:self.userNamelabel];
            
            self.userPointLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 20, 140, 15)];
            self.userPointLabel.textColor = [UIColor whiteColor];
            self.userPointLabel.backgroundColor = [UIColor clearColor];
           
            [self.bgUserView addSubview:self.userPointLabel];
            
            self.predepoitLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 40, 140, 15)];
            self.predepoitLabel.textColor = [UIColor whiteColor];
            self.predepoitLabel.backgroundColor = [UIColor clearColor];
            [self.bgUserView addSubview:self.predepoitLabel];
        }
        if ([userMyMall isKindOfClass:[fiveMyMallmodel class]]) {
            self.userNamelabel.text = userMyMall.user_name;
            self.userPointLabel.text = [[NSString alloc] initWithFormat:@"积分：%@", userMyMall.point];
            self.predepoitLabel.text = [[NSString alloc] initWithFormat:@"预存款：%@", userMyMall.predepoit];
            [self.userImage setImageWithURL:[NSURL URLWithString:userMyMall.avator] placeholderImage:[UIImage imageNamed:@"default_user_portrait.gif"]];
        }else
        {
            self.userNamelabel.text = @"";
            self.userPointLabel.text = @"";
            self.predepoitLabel.text = @"";
            [self.userImage setImageWithURL:[NSURL URLWithString:userMyMall.avator] placeholderImage:[UIImage imageNamed:@"default_user_portrait.gif"]];
        }
    }else
    {
        [self.bgUserView removeFromSuperview]; //释放用户信息
        self.bgUserView = nil;
        if (self.registeredButton == nil) {
            //注册
            self.registeredButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.registeredButton.frame = CGRectMakeEx(130, 50, 60, 25);
            self.registeredButton.backgroundColor = [UIColor whiteColor];
            [self.registeredButton setTitle:@"注册" forState:UIControlStateNormal];
            [self.registeredButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            self.registeredButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.registeredButton addTarget:self action:@selector(registeredAction) forControlEvents:UIControlEventTouchUpInside]; //注册
            [self addSubview:self.registeredButton];
            
            //登陆
            self.signInButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.signInButton.frame = CGRectMakeEx(200, 50, 60, 25);
            self.signInButton.backgroundColor = [UIColor whiteColor];
            [self.signInButton setTitle:@"登陆" forState:UIControlStateNormal];
            [self.signInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.signInButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.signInButton addTarget:self action:@selector(signInAction) forControlEvents:UIControlEventTouchUpInside]; //登陆
            [self addSubview:self.signInButton];
        }
    }
}

#pragma mark - 动作实现

-(void)comeBackActionString:(void(^)(NSString *string))action  //传回动作的名字
{
    self.string = [[fiveBlockString alloc] init];
    self.string.action = action;
}

//注册动作
-(void)registeredAction
{
    //作用: 原来被点击执行target-action对应的方法
    //现在: 判断action是否已经设置block, 如果被设置, 执行block
    if(self.string.action)
    {
        self.string.action(@"registeredAction");
    }
}
//登陆动作
-(void)signInAction
{
    if(self.string.action)
    {
        self.string.action(@"signInAction");
    }
}
//头像点击动作
-(void)userAction
{
    if(self.string.action)
    {
        self.string.action(@"userAction");
    }
}
//关注的商品点击动作
-(void)attentionAction
{
    if(self.string.action)
    {
        self.string.action(@"attentionAction");
    }
}
//浏览记录点击动作
-(void)browseAction
{
    if(self.string.action)
    {
        self.string.action(@"browseAction");
    }
}
//地址点击动作
-(void)addressAction
{
    if(self.string.action)
    {
        self.string.action(@"addressAction");
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
