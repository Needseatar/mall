//
//  PaymentMethodTableViewCell.m
//  mall
//
//  Created by Mihua on 20/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "PaymentMethodTableViewCell.h"

@interface PaymentMethodTableViewCell ()


@property (retain, nonatomic) UIView *bgView;
@property (retain, nonatomic) UIView *bgPayMethod;
@property (retain, nonatomic) UILabel *payTitleLabel;
@property (retain, nonatomic) UILabel *mustPromptLabel;

@end


@implementation PaymentMethodTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(orderRightLeftWidth, 0, delegate.ViewFrame.size.width-2*orderRightLeftWidth, payMethodCellHeight)];
        self.bgView.layer.borderWidth = 1;
        self.bgView.layer.cornerRadius =6;
        self.bgView.layer.shadowOffset=CGSizeMake(6, 6); //设置偏移
        self.bgView.layer.shadowOpacity=0.8;  //设置影子
        self.bgView.layer.borderColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1].CGColor;
        self.bgView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.bgView];
        
        //支付方式背景视图
        self.bgPayMethod = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, 0, self.bgView.frame.size.width-2*orderTextwidth, 50)];
        self.bgPayMethod.backgroundColor = [UIColor grayColor];
        [self.bgView addSubview:self.bgPayMethod];
        
        //支付方式
        self.payTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 50)];
        self.payTitleLabel.text = @"支付方式";
        self.payTitleLabel.font = [UIFont systemFontOfSize:18];
        self.payTitleLabel.backgroundColor = [UIColor orangeColor];
        [self.bgPayMethod addSubview:self.payTitleLabel];
        
        //支付方式后面的提示
        self.mustPromptLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.payTitleLabel.frame.origin.x+self.payTitleLabel.frame.size.width, 0, 30, 50)];
        self.mustPromptLabel.font = [UIFont systemFontOfSize:18];
        self.mustPromptLabel.backgroundColor = [UIColor blueColor];
        [self.bgPayMethod addSubview:self.mustPromptLabel];
        
//        //电话号码
//        self.telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.peopleNameLabel.frame.origin.x+self.peopleNameLabel.frame.size.width, 0, self.bgPeopleView.frame.size.width/2.0, 50)];
//        self.telephoneLabel.textAlignment = NSTextAlignmentRight;
//        self.telephoneLabel.font = [UIFont systemFontOfSize:13];
//        self.backgroundColor = [UIColor magentaColor];
//        [self.bgPeopleView addSubview:self.telephoneLabel];
//        
//        //电话号码图标
//        self.telephoneImageView = [[UIImageView alloc] init];
//        self.telephoneImageView.image = [UIImage imageNamed:@"shopping_checkout_phone_icon@2x.png"];
//        [self.bgPeopleView addSubview:self.telephoneImageView];
//        
//        //画虚线
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, self.bgPeopleView.frame.origin.y+self.bgPeopleView.frame.size.height, self.bgView.frame.size.width-2*orderTextwidth, 1)];
//        [self drawDashLine:lineView lineLength:8 lineSpacing:4 lineColor:[UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1]]; //画虚线
//        [self.bgView addSubview:lineView];
//        
//        //收件地址背景视图
//        self.bgAdressView = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, lineView.frame.size.height+lineView.frame.origin.y, self.bgView.frame.size.width-2*orderTextwidth, 50)];
//        self.bgAdressView.backgroundColor = [UIColor purpleColor];
//        [self.bgView addSubview:self.bgAdressView];
//        
//        
//        //收件人地址标题
//        self.adressTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 50)];
//        self.adressTitleLabel.text = @"收件人地址:";
//        self.adressTitleLabel.font = [UIFont systemFontOfSize:13];
//        self.adressTitleLabel.backgroundColor = [UIColor redColor];
//        [self.bgAdressView addSubview:self.adressTitleLabel];
//        
//        //收件人地址
//        self.adressnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.adressTitleLabel.frame.origin.x+self.adressTitleLabel.frame.size.width, 0, self.bgAdressView.frame.size.width-(self.adressTitleLabel.frame.origin.x+self.adressTitleLabel.frame.size.width), 50)];
//        self.adressnameLabel.numberOfLines=3;
//        self.adressnameLabel.font = [UIFont systemFontOfSize:15];
//        self.adressnameLabel.backgroundColor = [UIColor grayColor];
//        [self.bgAdressView addSubview:self.adressnameLabel];
//        
//        [self setBackgroundColor:[UIColor redColor]];
        
        [self setBackgroundColor:[UIColor redColor]];
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
