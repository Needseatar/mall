//
//  downSettlementTableViewCell.m
//  mall
//
//  Created by Mihua on 18/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "downSettlementTableViewCell.h"

@interface downSettlementTableViewCell ()

@property (retain, nonatomic) UIImageView *bgImageView;
@property (retain, nonatomic) UILabel     *SUMLabel;
@property (retain, nonatomic) UILabel     *SUMPaceLabel;
@property (retain, nonatomic) UIButton    *submitOrderButton;

@end


@implementation downSettlementTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        
        //订单的背景视图
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(orderRightLeftWidth, 0, delegate.ViewFrame.size.width-2*orderRightLeftWidth, 80)];
        UIImage *img = [UIImage imageNamed:@"shopping_cart_body_bg.png"];
        [self.bgImageView setImage:img];
        self.bgImageView.contentMode = UIViewContentModeScaleToFill;
        self.bgImageView.userInteractionEnabled = YES;
        [self addSubview:self.bgImageView];
        
        //画虚线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(orderTextwidth, 0, self.bgImageView.frame.size.width-2*orderTextwidth, 1)];
        [self drawDashLine:lineView lineLength:8 lineSpacing:4 lineColor:[UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1]]; //画虚线
        [self.bgImageView addSubview:lineView];
        
        //总额字体
        self.SUMLabel = [[UILabel alloc] initWithFrame:CGRectMake(orderTextwidth, 10, self.bgImageView.frame.size.width-orderTextwidth-110, 30)];
        self.SUMLabel.text = @"总额:";
        self.SUMLabel.font = [UIFont systemFontOfSize:20];
        self.SUMLabel.backgroundColor = [UIColor greenColor];
        [self.bgImageView addSubview:self.SUMLabel];
        
        //总额价格
        self.SUMPaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.SUMLabel.frame.origin.x, self.SUMLabel.frame.origin.y+self.SUMLabel.frame.size.height, self.bgImageView.frame.size.width-orderTextwidth-110, self.SUMLabel.frame.size.height)];
        self.SUMPaceLabel.textColor = [UIColor redColor];
        self.SUMPaceLabel.backgroundColor = [UIColor greenColor];
        [self.bgImageView addSubview:self.SUMPaceLabel];
        
        //提交订单
        self.submitOrderButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.submitOrderButton.frame = CGRectMake(self.bgImageView.frame.size.width-110, 15, 110-2*orderTextwidth, 50);
        [self.submitOrderButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [self.submitOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.submitOrderButton setBackgroundColor:[UIColor redColor]];
        self.submitOrderButton.titleLabel.font = [UIFont systemFontOfSize:20];
        self.submitOrderButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.submitOrderButton.userInteractionEnabled = YES;
        [self.submitOrderButton addTarget:self action:@selector(submitOrder) forControlEvents:UIControlEventTouchUpInside];
        [self.bgImageView addSubview:self.submitOrderButton];
        
    }
    return self;
}


-(void)setGoodsPace:(float)pace
{
    self.SUMPaceLabel.text = [NSString stringWithFormat:@"￥%.2f", pace];
}

-(void)submitOrder
{
    ;
    ;
    ;
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
