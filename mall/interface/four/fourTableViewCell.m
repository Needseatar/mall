//
//  fourTableViewCell.m
//  mall
//
//  Created by Mihua on 7/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "fourTableViewCell.h"

@interface fourTableViewCell ()

@property (retain, nonatomic) UIImageView *leftImage;
@property (retain, nonatomic) UILabel     *titleLabel;
@property (retain, nonatomic) UILabel     *paceLabel;

@property (retain, nonatomic) UIButton    *selectNumberReduceButton; //数量减
@property (retain, nonatomic) UITextField *selectNumberTextfiled;  //数量
@property (retain, nonatomic) UIButton    *selectNumberAddButton;  //数量加

@property (retain, nonatomic) NSArray     *arrayData;

@end

@implementation fourTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //左边图片
        self.leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 80, 80)];
        [self addSubview:self.leftImage];
        
        //标题
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 2;
        [self addSubview:self.titleLabel];
        
        //价格
        self.paceLabel = [[UILabel alloc] init];
        self.paceLabel.textColor = [UIColor redColor];
        [self addSubview:self.paceLabel];
        
        //选择数量
        self.selectNumberReduceButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.selectNumberReduceButton.frame = CGRectMake(80+5, 65, 30, 30);
        [self.selectNumberReduceButton setTitle:@"-" forState:UIControlStateNormal];
        self.selectNumberReduceButton.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1];
        [self.selectNumberReduceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.selectNumberReduceButton.layer.masksToBounds = YES;  //告诉layer将位于它之下的layer都遮盖住
        self.selectNumberReduceButton.layer.cornerRadius =6;
        self.selectNumberReduceButton.layer.borderWidth = 2;//边框宽度
        self.selectNumberReduceButton.layer.borderColor = [[UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1] CGColor];//边框颜色
        [self.selectNumberReduceButton addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectNumberReduceButton];
        
        self.selectNumberTextfiled = [[UITextField alloc] init];
        self.selectNumberTextfiled.frame = CGRectMake(80+30+5, 65, 50, 30);
        self.selectNumberTextfiled.textAlignment = NSTextAlignmentCenter;
        self.selectNumberTextfiled.backgroundColor = [UIColor whiteColor];
        self.selectNumberTextfiled.autocapitalizationType = UITextAutocapitalizationTypeNone;  //设置键盘不大写
        self.selectNumberTextfiled.keyboardType = UIKeyboardTypeNumberPad; //设置输入键盘
        self.selectNumberTextfiled.userInteractionEnabled = NO;
        self.selectNumberTextfiled.layer.masksToBounds = YES;  //告诉layer将位于它之下的layer都遮盖住
        self.selectNumberTextfiled.layer.cornerRadius =6;
        self.selectNumberTextfiled.layer.borderWidth = 2;//边框宽度
        self.selectNumberTextfiled.layer.borderColor = [[UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1] CGColor];//边框颜色
        [self addSubview:self.selectNumberTextfiled];
        
        self.selectNumberAddButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.selectNumberAddButton.frame = CGRectMake(80+30+50+5, 65, 30, 30);
        [self.selectNumberAddButton setTitle:@"+" forState:UIControlStateNormal];
        self.selectNumberAddButton.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1];
        [self.selectNumberAddButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.selectNumberAddButton.layer.masksToBounds = YES;  //告诉layer将位于它之下的layer都遮盖住
        self.selectNumberAddButton.layer.cornerRadius =6;
        self.selectNumberAddButton.layer.borderWidth = 2;//边框宽度
        self.selectNumberAddButton.layer.borderColor = [[UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1] CGColor];//边框颜色
        [self.selectNumberAddButton addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectNumberAddButton];

    }
    return self;
}

-(void)setTextAndImage:(NSArray *)arrayData fram:(CGRect)fr cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //洗白
    [self.leftImage setImage:[UIImage imageNamed:@""]];
    self.selectNumberTextfiled.text = @"1";
    self.titleLabel.frame = CGRectMake(80+5, 5, fr.size.width-5-80, 45);
    self.paceLabel.frame = CGRectMake(80+5, 5+45, fr.size.width-5-80, 15);
    self.titleLabel.text = @"";
    self.paceLabel.text = @"";
    self.selectNumberReduceButton.tag = 0;
    self.selectNumberAddButton.tag = 0;
    
    self.arrayData = arrayData;
    shopingCarModel *data = arrayData[indexPath.section];
    self.selectNumberReduceButton.tag = indexPath.section; //用来辨认是第几个cell
    self.selectNumberAddButton.tag = indexPath.section;
    
    
    [self.leftImage setImageWithURL:[NSURL URLWithString:data.goods_image_url]];
    self.titleLabel.text = data.goods_name;
    self.paceLabel.text = [NSString stringWithFormat:@"单价:￥%@", data.goods_price];
    self.selectNumberTextfiled.text = data.goods_num;
}


#pragma mark - 按钮的实现数量的加减
-(void)buttonAction1:(UIButton *)but
{
    NSInteger number;
    number = [self.selectNumberTextfiled.text integerValue]-1;
    if (number<1) {
        number = 1;
    }
    
    shopingCarModel *data = self.arrayData[but.tag];
    data.goods_num = [NSString stringWithFormat:@"%ld", (long)number];//修改请求回来的model
    self.selectNumberTextfiled.text = [NSString stringWithFormat:@"%ld", (long)number];
}
-(void)buttonAction2:(UIButton *)but
{
    NSInteger number;
    number = [self.selectNumberTextfiled.text integerValue]+1;
    shopingCarModel *data = self.arrayData[but.tag];
    data.goods_num = [NSString stringWithFormat:@"%ld", (long)number]; //修改请求回来的model
    self.selectNumberTextfiled.text = [NSString stringWithFormat:@"%ld", (long)number];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
