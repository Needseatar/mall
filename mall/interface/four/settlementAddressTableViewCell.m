//
//  settlementAddressTableViewCell.m
//  mall
//
//  Created by Mihua on 19/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "settlementAddressTableViewCell.h"


@interface settlementAddressTableViewCell ()


@property (retain, nonatomic) UIView      *bgView;

@property (retain, nonatomic) UIView      *bgPeopleView;
@property (retain, nonatomic) UILabel     *peopleTitleLabel;
@property (retain, nonatomic) UILabel     *peopleNameLabel;
@property (retain, nonatomic) UIImageView *telephoneImageView;
@property (retain, nonatomic) UILabel     *telephoneLabel;

@property (retain, nonatomic) UIView      *bgAdressView;
@property (retain, nonatomic) UILabel     *adressTitleLabel;
@property (retain, nonatomic) UILabel     *adressnameLabel;;

@end


@implementation settlementAddressTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(orderRightLeftWidth, 0, delegate.ViewFrame.size.width-2*orderRightLeftWidth, orderAddressCellHeight)];
        self.bgView.layer.borderWidth = 1;
        self.bgView.layer.cornerRadius =6;
        self.bgView.layer.shadowOffset=CGSizeMake(6, 6); //设置偏移
        self.bgView.layer.shadowOpacity=0.8;  //设置影子
        self.bgView.layer.borderColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1].CGColor;
        self.bgView.backgroundColor = greenColorDebug;
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressSkip)];//加载点击动作
        [self.bgView addGestureRecognizer:tapAction];
        self.bgView.userInteractionEnabled = YES;
        [self addSubview:self.bgView];
        
        //收件栏的背景视图
        self.bgPeopleView = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, 0, self.bgView.frame.size.width-2*orderTextwidth, (orderAddressCellHeight-1)/2.0)];
        self.bgPeopleView.backgroundColor = redColorDebug;
        [self.bgView addSubview:self.bgPeopleView];
        
        //收件人
        self.peopleTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, (orderAddressCellHeight-1)/2.0)];
        self.peopleTitleLabel.text = @"收件人:";
        self.peopleTitleLabel.font = [UIFont systemFontOfSize:13];
        self.peopleTitleLabel.backgroundColor = greenColorDebug;
        [self.bgPeopleView addSubview:self.peopleTitleLabel];
        
        //收件人名字
        self.peopleNameLabel = [[UILabel alloc] init];
        self.peopleNameLabel.font = [UIFont systemFontOfSize:18];
        self.peopleNameLabel.backgroundColor = blueColorDebug;
        [self.bgPeopleView addSubview:self.peopleNameLabel];
        
        //电话号码
        self.telephoneLabel = [[UILabel alloc] init];
        self.telephoneLabel.textAlignment = NSTextAlignmentRight;
        self.telephoneLabel.font = [UIFont systemFontOfSize:13];
        self.telephoneLabel.backgroundColor = blueColorDebug;
        [self.bgPeopleView addSubview:self.telephoneLabel];
        
        //电话号码图标
        self.telephoneImageView = [[UIImageView alloc] init];
        self.telephoneImageView.image = [UIImage imageNamed:@"shopping_checkout_phone_icon@2x.png"];
        self.telephoneImageView.backgroundColor = greenColorDebug;
        [self.bgPeopleView addSubview:self.telephoneImageView];
        
        //画虚线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, self.bgPeopleView.frame.origin.y+self.bgPeopleView.frame.size.height, self.bgView.frame.size.width-2*orderTextwidth, 1)];
        [self drawDashLine:lineView lineLength:8 lineSpacing:4 lineColor:[UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1]]; //画虚线
        [self.bgView addSubview:lineView];
        
        //收件地址背景视图
        self.bgAdressView = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, lineView.frame.size.height+lineView.frame.origin.y, self.bgView.frame.size.width-2*orderTextwidth, (orderAddressCellHeight-1)/2.0)];
        self.bgAdressView.backgroundColor = blueColorDebug;
        [self.bgView addSubview:self.bgAdressView];
        
        
        //收件人地址标题
        self.adressTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, (orderAddressCellHeight-1)/2.0)];
        self.adressTitleLabel.text = @"收件人地址:";
        self.adressTitleLabel.font = [UIFont systemFontOfSize:13];
        self.adressTitleLabel.backgroundColor = greenColorDebug;
        [self.bgAdressView addSubview:self.adressTitleLabel];
        
        //收件人地址
        self.adressnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.adressTitleLabel.frame.origin.x+self.adressTitleLabel.frame.size.width, 0, self.bgAdressView.frame.size.width-(self.adressTitleLabel.frame.origin.x+self.adressTitleLabel.frame.size.width), (orderAddressCellHeight-1)/2.0)];
        self.adressnameLabel.numberOfLines=3;
        self.adressnameLabel.font = [UIFont systemFontOfSize:15];
        self.adressnameLabel.backgroundColor = redColorDebug;
        [self.bgAdressView addSubview:self.adressnameLabel];
        
    }
    return self;
}

-(void)setPeopleInformation:(addressInfo *)data
{
    self.peopleNameLabel.text = data.true_name;
    self.telephoneLabel.text = data.mob_phone;
    self.adressnameLabel.text = [NSString stringWithFormat:@"%@ %@", data.area_info, data.address];
    //计算电话图标的位置
    CGRect fram = CGRectMake(200, self.bgPeopleView.frame.size.height/2.0-20/2.0, 20, 20);
    CGSize size =[self.telephoneLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    fram.origin.x = self.bgPeopleView.frame.size.width-size.width-20;
    self.telephoneImageView.frame = fram;
    
    //设置电话号码的位置
    self.telephoneLabel.frame = CGRectMake(self.telephoneImageView.frame.origin.x+self.telephoneImageView.frame.size.width, 0, self.bgPeopleView.frame.size.width-(self.telephoneImageView.frame.origin.x+self.telephoneImageView.frame.size.width), (orderAddressCellHeight-1)/2.0);
    
    //设置收件人的位置
    self.peopleNameLabel.frame = CGRectMake(self.peopleTitleLabel.frame.origin.x+self.peopleTitleLabel.frame.size.width, 0, self.bgPeopleView.frame.size.width-(self.peopleTitleLabel.frame.origin.x+self.peopleTitleLabel.frame.size.width)-self.telephoneImageView.frame.size.width-self.telephoneLabel.frame.size.width, (orderAddressCellHeight-1)/2.0);
}

-(void)addressSkip
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InFourViewControlSkip" object:[NSString stringWithFormat:@"AddressSkip"]];
}

#pragma mark - 画虚线函数
-(void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    /**
     ** lineView:	   需要绘制成虚线的view
     ** lineLength:	 虚线的宽度
     ** lineSpacing:	虚线的间距
     ** lineColor:	  虚线的颜色
     **/
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
