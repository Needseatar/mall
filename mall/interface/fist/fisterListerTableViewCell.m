//
//  fisterListerTableViewCell.m
//  mall
//
//  Created by Mihua on 22/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterListerTableViewCell.h"

#define viewNumber 2

@interface fisterListerTableViewCell ()

@property (retain, nonatomic) UIView *bgView;
@property (retain, nonatomic) NSArray *data;

@end

@implementation fisterListerTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //背景视图
        self.bgView = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 0, 320, 230)];
        self.bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgView];
        
        for (int i=0; i<viewNumber; i++) {
            //背景button
            UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
            bgButton.frame = CGRectMakeEx(i*157+5, 15, 153, 210);
            bgButton.tag = 888+i;
            bgButton.backgroundColor = [UIColor whiteColor];
            bgButton.layer.cornerRadius =6;
            bgButton.layer.borderWidth = 1;//边框宽度
            bgButton.layer.borderColor = [[UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1] CGColor];//边框颜色
            [bgButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.bgView addSubview:bgButton];
            
            //图像
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMakeEx(0, 10, 153, 130)];
            imageView.tag = 440+i;
            imageView.backgroundColor = [UIColor clearColor];
            [bgButton addSubview:imageView];
            
            //标题
            UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(3, 140, 153-6, 30)];
            titlelabel.tag = 450+i;
            titlelabel.numberOfLines = 2;
            titlelabel.font = [UIFont systemFontOfSize:10];
            titlelabel.backgroundColor = [UIColor clearColor];
            [bgButton addSubview:titlelabel];
            
            //灰色的分隔线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMakeEx(6, 173, 153-12, 1)];
            lineView.tag = 460+i;
            lineView.backgroundColor = [UIColor colorWithRed:218.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:1];
            [bgButton addSubview:lineView];
            
            //价格
            UILabel *pacelabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 175, 153, 30)];
            pacelabel.tag = 470+i;
            pacelabel.textColor = [UIColor redColor];
            pacelabel.backgroundColor = [UIColor clearColor];
            pacelabel.font = [UIFont systemFontOfSize:18];
            [bgButton addSubview:pacelabel];
            
            
            [self setBackgroundColor:[UIColor brownColor]];
        }
    }
    return self;
}

-(void)setTextAndImage:(NSArray *)goodsDataArray
{
    self.data = goodsDataArray;
    for (int i=0; i<viewNumber; i++) {
        UIButton *bgButton = [self.bgView viewWithTag:888+i];
        UIImageView *imageView = [self.bgView viewWithTag:440+i];
        UILabel *titlelabel = [self.bgView viewWithTag:450+i];
        UILabel *pacelabel = [self.bgView viewWithTag:470+i];
        
        //洗白
        bgButton.hidden = YES;
        [imageView setImage:[UIImage imageNamed:@""]];
        titlelabel.text = @"";
        pacelabel.text = @"";
        
        
        fisterList *goodsData;
        if (goodsDataArray.count == 1) {
            if (i!=0) { //设置单个数据的隐藏
                bgButton.hidden = YES;
                break;
            }else
            {
                goodsData = goodsDataArray[i];
            }
        }else
        {
            goodsData = goodsDataArray[i];
        }
        bgButton.hidden = NO;
        [imageView setImageWithURL:[NSURL URLWithString:goodsData.goods_image]];
        titlelabel.text = goodsData.goods_name;
        pacelabel.text = [NSString stringWithFormat:@"￥:%@", goodsData.goods_promotion_price];
    }
}

-(void)buttonAction:(UIButton *)but
{
    if (but.tag-888 == 0) {
        //创建一个消息对象
        //发送消息
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mallID" object:self.data[0]];
    }else if (but.tag-888 == 1)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mallID" object:self.data[1]];
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
