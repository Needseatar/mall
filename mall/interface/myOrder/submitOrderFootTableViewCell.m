//
//  submitOrderFootTableViewCell.m
//  mall
//
//  Created by Mihua on 23/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "submitOrderFootTableViewCell.h"


@interface submitOrderFootTableViewCell ()

@property (retain, nonatomic) UILabel *shippingFee;
@property (retain, nonatomic) UILabel *payAmount;
@property (retain, nonatomic) UILabel *payStatus;
@property (retain, nonatomic) UIView  *bgCancelView;

@property (retain, nonatomic) NSString *orderID;
@property (strong, nonatomic) void (^action)(NSString *string);

@end

@implementation submitOrderFootTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        self.shippingFee = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, delegate.ViewFrame.size.width, 30)];
        self.shippingFee.textAlignment = NSTextAlignmentRight;
        self.shippingFee.backgroundColor = redColorDebug;
        [self addSubview:self.shippingFee];
        
        self.payAmount = [[UILabel alloc] initWithFrame:CGRectMake(0, self.shippingFee.frame.size.height+self.shippingFee.frame.origin.y, delegate.ViewFrame.size.width, 30)];
        self.payAmount.textAlignment = NSTextAlignmentRight;
        self.payAmount.textColor = [UIColor colorWithRed:255/255.0f green:165/255.0f blue:0.0 alpha:1];
        self.payAmount.backgroundColor = blueColorDebug;
        [self addSubview:self.payAmount];
        
        self.payStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, self.payAmount.frame.size.height+self.payAmount.frame.origin.y, delegate.ViewFrame.size.width, 30)];
        self.payStatus.textColor = [UIColor colorWithRed:0.0 green:153/250.0f blue:0.0 alpha:1];
        self.payStatus.textAlignment = NSTextAlignmentRight;
        self.payStatus.backgroundColor = redColorDebug;
        [self addSubview:self.payStatus];
        
        
        self.bgCancelView = [[UIView alloc] initWithFrame:CGRectMake(5, self.payStatus.frame.size.height+self.payStatus.frame.origin.y+5, delegate.ViewFrame.size.width-2*5, 50)];
        self.bgCancelView.backgroundColor = redColorDebug;
        [self addSubview:self.bgCancelView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, self.bgCancelView.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1];
        [self.bgCancelView addSubview:lineView];
        
        UIButton *cancelOrder = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelOrder.frame = CGRectMake(self.bgCancelView.frame.size.width-60-5, lineView.frame.size.height+lineView.frame.origin.y+10, 60, 30);
        [cancelOrder setBackgroundColor:[UIColor redColor]];
        [cancelOrder setTitle:@"取消订单" forState:UIControlStateNormal];
        [cancelOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelOrder addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bgCancelView addSubview:cancelOrder];
        
        self.backgroundColor = greenColorDebug;
    }
    return self;
}

-(void)setStrigLabel:(dataOrderListModel *)data cellOrderID:(void(^)(NSString *cellOrderID))action
{
    self.shippingFee.text = [NSString stringWithFormat:@"运费:￥%@", data.shipping_fee];
    self.payAmount.text = [NSString stringWithFormat:@"合计:￥%@", data.goods_amount];
    self.payStatus.text = data.state_desc;
    
    self.action = action;
    self.orderID = data.order_id;
    
    if ([data.if_cancel integerValue]) {
        self.bgCancelView.hidden = NO;
    }else
    {
        self.bgCancelView.hidden = YES;
    }
}

-(void)buttonAction
{
    if(self.action)
    {
        self.action(self.orderID);
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
