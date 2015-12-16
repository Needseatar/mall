//
//  goodsInformationpaceTableViewCell.m
//  mall
//
//  Created by Mihua on 15/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "goodsInformationpaceTableViewCell.h"

@interface goodsInformationpaceTableViewCell ()

@property (retain, nonatomic) UILabel *upLabel;

@property (retain, nonatomic) UIView *bgPaceView;

@property (retain, nonatomic) UILabel *leftPriceLabel;
@property (retain, nonatomic) UILabel *rightPriceLabel;

@property (retain, nonatomic) UILabel *leftMarketPriceLabel;
@property (retain, nonatomic) UILabel *rightMarketPriceLabel;
@property (retain, nonatomic) UIView  *rightMarketPriceLine;

@property (retain, nonatomic) UILabel *leftSalenumLabel;
@property (retain, nonatomic) UILabel *rightSalenumLabel;

@property (retain, nonatomic) UILabel *leftStoreNameLabel;
@property (retain, nonatomic) UILabel *rightStoreNameLabel;

@end

@implementation goodsInformationpaceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //上边的label
        self.upLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(5, 5, 310, 0)];
        self.upLabel.numberOfLines = 0;
        self.upLabel.textColor = [UIColor blackColor];
        self.upLabel.backgroundColor = [UIColor clearColor];
        self.upLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.upLabel];
        
        //价格的背景视图
        self.bgPaceView = [[UIView alloc] init];
        self.bgPaceView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgPaceView];
        
        //价格标题
        self.leftPriceLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 0, 50, 30)];
        self.leftPriceLabel.backgroundColor = [UIColor clearColor];
        self.leftPriceLabel.textColor = [UIColor blackColor];
        self.leftPriceLabel.font = [UIFont  systemFontOfSize:18];
        [self.bgPaceView addSubview:self.leftPriceLabel];
        
        //价格
        self.rightPriceLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(50, 0, 310-50, 30)];
        self.rightPriceLabel.backgroundColor = [UIColor clearColor];
        self.rightPriceLabel.textColor = [UIColor redColor];
        self.rightPriceLabel.font = [UIFont  systemFontOfSize:18];
        [self.bgPaceView addSubview:self.rightPriceLabel];
        
        //市场价格标题
        self.leftMarketPriceLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 30, 60, 30)];
        self.leftMarketPriceLabel.backgroundColor = [UIColor clearColor];
        self.leftMarketPriceLabel.textColor = [UIColor blackColor];
        self.leftMarketPriceLabel.font = [UIFont  systemFontOfSize:18];
        [self.bgPaceView addSubview:self.leftMarketPriceLabel];
        
        //市场价格
        self.rightMarketPriceLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(60, 30, 310-60, 30)];
        self.rightMarketPriceLabel.backgroundColor = [UIColor clearColor];
        self.rightMarketPriceLabel.textColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
        self.rightMarketPriceLabel.font = [UIFont  systemFontOfSize:18];
        [self.bgPaceView addSubview:self.rightMarketPriceLabel];
        
        //市场价格标题的划线
        self.rightMarketPriceLine = [[UIView alloc] init];
        self.rightMarketPriceLine.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
        [self.rightMarketPriceLabel addSubview:self.rightMarketPriceLine];
        
        //销量标题
        self.leftSalenumLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 60, 50, 30)];
        self.leftSalenumLabel.backgroundColor = [UIColor clearColor];
        self.leftSalenumLabel.textColor = [UIColor blackColor];
        self.leftSalenumLabel.font = [UIFont  systemFontOfSize:18];
        [self.bgPaceView addSubview:self.leftSalenumLabel];
        
        //销量
        self.rightSalenumLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(50, 60, 310-50, 30)];
        self.rightSalenumLabel.backgroundColor = [UIColor clearColor];
        self.rightSalenumLabel.textColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
        self.rightSalenumLabel.font = [UIFont  systemFontOfSize:18];
        [self.bgPaceView addSubview:self.rightSalenumLabel];
        
        //销量标题
        self.leftSalenumLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 60, 50, 30)];
        self.leftSalenumLabel.backgroundColor = [UIColor clearColor];
        self.leftSalenumLabel.textColor = [UIColor blackColor];
        self.leftSalenumLabel.font = [UIFont  systemFontOfSize:18];
        [self.bgPaceView addSubview:self.leftSalenumLabel];
        
        //服务
        self.leftStoreNameLabel = [[UILabel alloc] init];
        self.leftStoreNameLabel.backgroundColor = [UIColor clearColor];
        self.leftStoreNameLabel.textColor = [UIColor blackColor];
        self.leftStoreNameLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.leftStoreNameLabel];
        
        //服务后面的文字
        self.rightStoreNameLabel = [[UILabel alloc] init];
        self.rightStoreNameLabel.backgroundColor = [UIColor clearColor];
        self.rightStoreNameLabel.textColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
        self.rightStoreNameLabel.numberOfLines = 0;
        self.rightStoreNameLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.rightStoreNameLabel];
        
    }
    return self;
}

-(void)setString:(dataCommodityInformation *)data
{
    //洗白
    self.upLabel.frame = CGRectMakeEx(5, 5, 310, 0);
    self.bgPaceView.frame = CGRectMake(self.upLabel.frame.origin.x, self.upLabel.frame.origin.y+self.upLabel.frame.size.height, widthEx(310), heightEx(90));
    self.upLabel.text = @"";
    self.leftPriceLabel.text = @"";
    self.rightPriceLabel.text = @"";
    self.leftMarketPriceLabel.text = @"";
    self.rightMarketPriceLabel.text = @"";
    self.leftSalenumLabel.text = @"";
    self.rightSalenumLabel.text = @"";
    
    if (data != nil) {
        //计算label的上标题的高度，并且设置其frame，和设置self.bgPaceView.frame
        self.upLabel.text = [data.goods_info goods_jingle];
        CGRect frame = self.upLabel.frame;
        frame.size.height = heightEx([self heightWithString:[data.goods_info goods_jingle] width:310 fontSize:18]);
        self.upLabel.frame = frame;
        self.bgPaceView.frame = CGRectMake(self.upLabel.frame.origin.x, self.upLabel.frame.origin.y+self.upLabel.frame.size.height, widthEx(310), heightEx(90));
        
        //加载字体
        self.leftPriceLabel.text = @"价格:";
        self.rightPriceLabel.text = [NSString stringWithFormat:@"￥%@", [data.goods_info goods_price]];
        
        self.leftMarketPriceLabel.text = @"市场价:";
        self.rightMarketPriceLabel.text = [NSString stringWithFormat:@"￥%@", [data.goods_info goods_marketprice]];
        CGSize size =[self.rightMarketPriceLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];  //计算text的长度
        self.rightMarketPriceLine.frame = CGRectMake(0, heightEx(16), size.width, 1);
        
        self.leftSalenumLabel.text = @"销量:";
        self.rightSalenumLabel.text = [NSString stringWithFormat:@"%@件", [data.goods_info goods_salenum]];
        
        self.leftStoreNameLabel.frame = CGRectMake(5, self.bgPaceView.frame.origin.y+self.bgPaceView.frame.size.height, 50, 30);
        self.leftStoreNameLabel.text = @"服务:";
        
        //设置服务
        self.rightStoreNameLabel.frame = CGRectMake(widthEx(5+50), self.bgPaceView.frame.origin.y+self.bgPaceView.frame.size.height, widthEx(310-50), heightEx(30));
        self.rightStoreNameLabel.text = [NSString stringWithFormat:@"由%@负责发货,并提供售后服务", [data.store_info store_name]];
        CGRect frame1 = self.rightStoreNameLabel.frame;
        frame1.size.height = heightEx([self heightWithString:self.rightStoreNameLabel.text width:310-50 fontSize:18]);
        self.rightStoreNameLabel.frame = frame1;
    }

}

#pragma mark - 计算label高度
-(CGFloat)heightWithString:(NSString *)string width:(CGFloat)width fontSize:(CGFloat)fontSize
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize + 1.5]} context:nil];
    
    return heightEx(rect.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
