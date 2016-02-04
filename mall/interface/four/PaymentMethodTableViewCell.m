//
//  PaymentMethodTableViewCell.m
//  mall
//
//  Created by Mihua on 20/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "PaymentMethodTableViewCell.h"

@interface PaymentMethodTableViewCell ()


@property (retain, nonatomic) UIView      *bgView;
@property (retain, nonatomic) UIView      *bgPayMethod;
@property (retain, nonatomic) UILabel     *payTitleLabel;
@property (retain, nonatomic) UILabel     *mustPromptLabel;
@property (retain, nonatomic) UILabel     *PayMethodLabel;
@property (retain, nonatomic) UIImageView *backImageView;
@property (retain, nonatomic) UIView      *bgInvoice;
@property (retain, nonatomic) UILabel     *invoiceTitleLabel;
@property (retain, nonatomic) UILabel     *invoiceNamelabel;
@property (retain, nonatomic) UIImageView *invoiceBackImageView;

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
        self.bgView.backgroundColor = greenColorDebug;
        [self addSubview:self.bgView];
        
        //支付方式背景视图
        self.bgPayMethod = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, 0, self.bgView.frame.size.width-2*orderTextwidth, (payMethodCellHeight-1)/2.0)];
        self.bgPayMethod.backgroundColor = redColorDebug;
        UITapGestureRecognizer *tapAction1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payMethodViewSkip)];//加载点击动作
        [self.bgPayMethod addGestureRecognizer:tapAction1];
        self.bgPayMethod.userInteractionEnabled = YES;
        [self.bgView addSubview:self.bgPayMethod];
        
        //支付方式
        self.payTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, (payMethodCellHeight-1)/2.0)];
        self.payTitleLabel.text = @"支付方式";
        self.payTitleLabel.font = [UIFont systemFontOfSize:18];
        self.payTitleLabel.backgroundColor = blueColorDebug;
        [self.bgPayMethod addSubview:self.payTitleLabel];
        
        //支付方式后面的提示
        self.mustPromptLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.payTitleLabel.frame.origin.x+self.payTitleLabel.frame.size.width, self.bgPayMethod.frame.size.height/2.0-20/2.0, 40, 20)];
        self.mustPromptLabel.text = @"必填";
        self.mustPromptLabel.textColor = [UIColor whiteColor];
        self.mustPromptLabel.layer.borderWidth = 1;
        self.mustPromptLabel.layer.cornerRadius = 5;
        self.mustPromptLabel.layer.borderColor = [UIColor colorWithRed:36/255.0f green:158/255.0f blue:246/255.0f alpha:1].CGColor;
        self.mustPromptLabel.layer.masksToBounds = YES;
        self.mustPromptLabel.font = [UIFont systemFontOfSize:18];
        self.mustPromptLabel.backgroundColor = [UIColor colorWithRed:36/255.0f green:158/255.0f blue:246/255.0f alpha:1];
        [self.bgPayMethod addSubview:self.mustPromptLabel];
        
        //付款的方式
        self.PayMethodLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mustPromptLabel.frame.origin.x+self.mustPromptLabel.frame.size.width, 0, self.bgPayMethod.frame.size.width-(self.mustPromptLabel.frame.origin.x+self.mustPromptLabel.frame.size.width)-18, 50)];
        self.PayMethodLabel.textAlignment = NSTextAlignmentRight;
        self.PayMethodLabel.font = [UIFont systemFontOfSize:13];
        self.PayMethodLabel.backgroundColor = [UIColor clearColor];
        self.PayMethodLabel.textAlignment = NSTextAlignmentRight;
        [self.bgPayMethod addSubview:self.PayMethodLabel];
        
        //付款后面的图标
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bgPayMethod.frame.size.width-10, self.bgPayMethod.frame.size.height/2.0-15/2.0, 10, 15)];
        self.backImageView.backgroundColor = redColorDebug;
        self.backImageView.image = [UIImage imageNamed:@"accsessory_arrow_right@2x.png"];
        [self.bgPayMethod addSubview:self.backImageView];
        
        //画虚线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, self.bgPayMethod.frame.origin.y+self.bgPayMethod.frame.size.height, self.bgView.frame.size.width-2*orderTextwidth, 1)];
        [self drawDashLine:lineView lineLength:8 lineSpacing:4 lineColor:[UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1]]; //画虚线
        [self.bgView addSubview:lineView];

        //发票背景视图
        self.bgInvoice = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, lineView.frame.size.height+lineView.frame.origin.y, self.bgView.frame.size.width-2*orderTextwidth, 50)];
        self.bgInvoice.backgroundColor = redColorDebug;
        UITapGestureRecognizer *tapAction2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(invoiceInformationSkip)];//加载点击动作
        [self.bgInvoice addGestureRecognizer:tapAction2];
        self.bgInvoice.userInteractionEnabled = YES;
        [self.bgView addSubview:self.bgInvoice];

        
        //发票信息
        self.invoiceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, (payMethodCellHeight-1)/2.0)];
        self.invoiceTitleLabel.text = @"发票信息";
        self.invoiceTitleLabel.font = [UIFont systemFontOfSize:18];
        self.invoiceTitleLabel.backgroundColor = greenColorDebug;
        [self.bgInvoice addSubview:self.invoiceTitleLabel];
        
        //发票详细信息
        self.invoiceNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(self.invoiceTitleLabel.frame.origin.x+self.invoiceTitleLabel.frame.size.width, 0, self.bgInvoice.frame.size.width-(self.invoiceTitleLabel.frame.origin.x+self.invoiceTitleLabel.frame.size.width)-18, (payMethodCellHeight-1)/2.0)];
        self.invoiceNamelabel.numberOfLines=3;
        self.invoiceNamelabel.font = [UIFont systemFontOfSize:13];
        self.invoiceNamelabel.numberOfLines = 3;
        self.invoiceNamelabel.textAlignment = NSTextAlignmentRight;
        self.invoiceNamelabel.backgroundColor = redColorDebug;
        [self.bgInvoice addSubview:self.invoiceNamelabel];
        
        //发票后面的图标
        self.invoiceBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bgInvoice.frame.size.width-10, self.bgInvoice.frame.size.height/2.0-15/2.0, 10, 15)];
        self.invoiceBackImageView.backgroundColor = greenColorDebug;
        self.invoiceBackImageView.image = [UIImage imageNamed:@"accsessory_arrow_right@2x.png"];
        [self.bgInvoice addSubview:self.invoiceBackImageView];
        
    }
    return self;
}

-(void)setPeopleInformation:(storeCartModel *)data payMethodString:(NSString *)payMethodString
{
    self.PayMethodLabel.text = payMethodString;
    self.invoiceNamelabel.text = data.inv_info.content;
    NSLog(@"%@", data.inv_info.content);
}

-(void)payMethodViewSkip
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InFourViewControlSkip" object:[NSString stringWithFormat:@"SetpPayMethodView"]];
}
-(void)invoiceInformationSkip
{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"InFourViewControlSkip" object:[NSString stringWithFormat:@"invoiceInformationSkip"]];
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
