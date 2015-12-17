//
//  goodsSpecificationsTableViewCell.m
//  mall
//
//  Created by Mihua on 16/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "goodsSpecificationsTableViewCell.h"


@interface goodsSpecificationsTableViewCell ()<UITextFieldDelegate>

@property (retain, nonatomic) UILabel     *specificationsLabel;

@property (retain, nonatomic) UILabel     *selectNumberTitleLabel;
@property (retain, nonatomic) UIButton    *selectNumberReduceButton;
@property (retain, nonatomic) UITextField *selectNumberTextfiled;
@property (retain, nonatomic) UIButton    *selectNumberAddButton;

@property (assign, nonatomic) NSInteger   maxSpecifications;

@property (retain, nonatomic) UIView      *bgSpecificationsView; //商品款式的背景视图

@end

@implementation goodsSpecificationsTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.specificationsLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(5, 5, 310, 30)];
        self.specificationsLabel.backgroundColor = [UIColor redColor];
        self.specificationsLabel.textColor = [UIColor blackColor];
        [self addSubview:self.specificationsLabel];
        
        //商品规格的背景视图
        self.bgSpecificationsView = [[UIView alloc] init];
        self.bgSpecificationsView.backgroundColor = [UIColor redColor];
        [self addSubview:self.bgSpecificationsView];
        
        //最后一栏的选择数量
        self.selectNumberTitleLabel = [[UILabel alloc] init];
        self.selectNumberTitleLabel.backgroundColor = [UIColor redColor];
        self.selectNumberTitleLabel.textColor = [UIColor blackColor];
        [self addSubview:self.selectNumberTitleLabel];
        
        self.selectNumberReduceButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.selectNumberReduceButton.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1];
        [self.selectNumberReduceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.selectNumberReduceButton.layer.masksToBounds = YES;  //告诉layer将位于它之下的layer都遮盖住
        self.selectNumberReduceButton.layer.cornerRadius =6;
        self.selectNumberReduceButton.layer.borderWidth = 2;//边框宽度
        self.selectNumberReduceButton.layer.borderColor = [[UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1] CGColor];//边框颜色
        self.selectNumberReduceButton.tag = 20;
        [self.selectNumberReduceButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectNumberReduceButton];
        
        self.selectNumberTextfiled = [[UITextField alloc] init];
        self.selectNumberTextfiled.textAlignment = NSTextAlignmentCenter;
        self.selectNumberTextfiled.backgroundColor = [UIColor whiteColor];
        self.selectNumberTextfiled.autocapitalizationType = UITextAutocapitalizationTypeNone;  //设置键盘不大写
        self.selectNumberTextfiled.keyboardType = UIKeyboardTypeNumberPad; //设置输入键盘
        self.selectNumberTextfiled.layer.masksToBounds = YES;  //告诉layer将位于它之下的layer都遮盖住
        self.selectNumberTextfiled.layer.cornerRadius =6;
        self.selectNumberTextfiled.layer.borderWidth = 2;//边框宽度
        self.selectNumberTextfiled.layer.borderColor = [[UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1] CGColor];//边框颜色
        self.selectNumberTextfiled.delegate = self;
        [self addSubview:self.selectNumberTextfiled];
        
        self.selectNumberAddButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.selectNumberAddButton.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1];
        [self.selectNumberAddButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.selectNumberAddButton.layer.masksToBounds = YES;  //告诉layer将位于它之下的layer都遮盖住
        self.selectNumberAddButton.layer.cornerRadius =6;
        self.selectNumberAddButton.layer.borderWidth = 2;//边框宽度
        self.selectNumberAddButton.layer.borderColor = [[UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1] CGColor];//边框颜色
        self.selectNumberAddButton.tag = 21;
        [self.selectNumberAddButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectNumberAddButton];
    }
    return self;
}

-(void)setString:(dataCommodityInformation *)data
{
    //洗白
    self.specificationsLabel.text = @"";
    
    
    if (data != nil) {
        //库存
        self.specificationsLabel.text = [NSString stringWithFormat:@"库存:%@件", [data.goods_info goods_storage]];
        self.maxSpecifications =[[data.goods_info goods_storage] integerValue]; //把库存的数量保存下来
        
        //创建每一个款式的背景视图和确定每一个款式视图的大小
        int i=0;
        for (NSDictionary *dic in [data.goods_info spec_name]) {
            NSLog(@"%@", dic);
            NSDictionary *dic2 = [data.goods_info spec_value];
            NSDictionary *dicspecValue = dic2[dic]; //通过字典的key找到在[data.goods_info spec_value]里面的字典数量
            
            //作用是计算这一个款式有多少组个两个按钮
            int grouInt  = (int)dicspecValue.count/2;
            float grouFl = dicspecValue.count/2.0;
            if (grouFl > (float)grouInt) {
                grouInt++;
            }
            UIView *bgView;
            if (i==0) {
                //加载背景视图
                bgView = [[UIView alloc] initWithFrame:CGRectMakeEx(0, 0, 310, grouInt*SpecificationHeight)];
                bgView.tag = 2000;
                i++;
                bgView.backgroundColor = [UIColor greenColor];
                [self.bgSpecificationsView addSubview:bgView];
                
            }else
            {
                UIView *upview = [self.bgSpecificationsView viewWithTag:2000+i-1]; //寻找上一个视图
                bgView = [[UIView alloc] initWithFrame:CGRectMake(widthEx(0), upview.frame.origin.x+upview.frame.size.height+Interval, heightEx(310), heightEx(grouInt*SpecificationHeight))];
                bgView.tag = 2000+i;
                i++;
                bgView.backgroundColor = [UIColor greenColor];
                [self.bgSpecificationsView addSubview:bgView];
            }
            //加载款式
            NSDictionary *dicSpecLabel = [data.goods_info spec_name];
            
            
            UILabel * specLabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(0, 0, 50, 30)];
            specLabel.backgroundColor = [UIColor redColor];
            specLabel.font = [UIFont systemFontOfSize:18];
            specLabel.text = [NSString stringWithFormat:@"%@:", dicSpecLabel[dic]];
            specLabel.tag = 4000;
            [bgView addSubview:specLabel];
            
            //加载款式的button
            NSArray *dicspecValueValues = [dicspecValue allValues];
            for (int l=0; l<dicspecValue.count; l++) {
                UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
                but1.frame = CGRectMakeEx(50+(l%2)*130, (l/2)*35, 120, 30);
                [but1 setTitle:dicspecValueValues[l] forState:UIControlStateNormal];
                but1.layer.masksToBounds = YES;  //告诉layer将位于它之下的layer都遮盖住
                but1.layer.cornerRadius =6;
                but1.layer.borderWidth = 2;//边框宽度
                if (l==0) {
                    but1.selected = YES;
                }else
                {
                    but1.selected = NO;
                }
                if (but1.selected ==YES) {
                    but1.layer.borderColor = [[UIColor redColor] CGColor];//边框颜色
                }else
                {
                    but1.layer.borderColor = [[UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1] CGColor];//边框颜色
                }
                [but1 addTarget:self action:@selector(specButton:) forControlEvents:UIControlEventTouchUpInside];
                [bgView addSubview:but1];
            }
        }
        ////设置全部商品款式的背景视图大小
        NSInteger numberBgViewHeight=0;
        for (int j=i-1; i>=0; j--) { //从最后一个视图开始寻找，然后计算出所有视图所占的高度
            if (j==0) {
                numberBgViewHeight = numberBgViewHeight+ SpecificationHeight;
                break;
            }
            numberBgViewHeight = numberBgViewHeight+ SpecificationHeight + Interval;
        }
        UIView *endView = [self.bgSpecificationsView viewWithTag:2000];//找到最上面的视图
        self.bgSpecificationsView.frame = CGRectMakeEx(5, 50, 310, endView.frame.origin.y+numberBgViewHeight);
        
        //设置商品的数量
        //数量的坐标，坐标是根据self.bgSpecificationsView.frame来确定位置的
        self.selectNumberTitleLabel.frame = CGRectMake(widthEx(5), self.bgSpecificationsView.frame.origin.y+self.bgSpecificationsView.frame.size.height +5, widthEx(50), heightEx(30));
        self.selectNumberReduceButton.frame = CGRectMake(widthEx(55), self.bgSpecificationsView.frame.origin.y+self.bgSpecificationsView.frame.size.height + 5, widthEx(30), heightEx(30));
        self.selectNumberTextfiled.frame = CGRectMake(widthEx(85), self.bgSpecificationsView.frame.origin.y+self.bgSpecificationsView.frame.size.height + 5, widthEx(50), heightEx(30));
        self.selectNumberAddButton.frame = CGRectMake(widthEx(135), self.bgSpecificationsView.frame.origin.y+self.bgSpecificationsView.frame.size.height +5, widthEx(30), heightEx(30));
        self.selectNumberTitleLabel.text = @"数量:";
        [self.selectNumberReduceButton setTitle:@"-" forState:UIControlStateNormal];
        self.selectNumberTextfiled.text = @"1";
        [self.selectNumberAddButton setTitle:@"+" forState:UIControlStateNormal];
        
    }
}

#pragma mark - 数量输入限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *textString =  [NSString stringWithFormat:@"%@%@", self.selectNumberTextfiled.text, string];
    if ([textString integerValue]>self.maxSpecifications) {
        self.selectNumberTextfiled.text = [NSString stringWithFormat:@"%ld", self.maxSpecifications];
        return NO;
    }else
    {
        if ([textString integerValue]<1) {
            self.selectNumberTextfiled.text = [NSString stringWithFormat:@"1"];
            return NO;
        }
    }
    return YES;
}
#pragma mark - 款式选择动作
-(void)specButton:(UIButton *)but
{
    UIView *bgview = [but superview];
    for (UIButton *notSelectButton in [bgview subviews]) {  //button 边框初始化
        if (notSelectButton.tag==4000) {  //去除label视图
            continue;
        }
        notSelectButton.selected = NO;
        notSelectButton.layer.borderColor = [[UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1] CGColor];//边框颜色
    }
    but.selected = YES;
    but.layer.borderColor = [[UIColor redColor] CGColor];//边框颜色
}

#pragma mark - 按钮的实现数量的加减
-(void)buttonAction:(UIButton *)but
{
    NSInteger number;
    if (but.tag == 20) {
        number = [self.selectNumberTextfiled.text integerValue]-1;
        if (number<1) {
            number = 1;
        }
    }else
    {
        number = [self.selectNumberTextfiled.text integerValue]+1;
        if (number>self.maxSpecifications) {
            number = self.maxSpecifications;
        }
    }
    self.selectNumberTextfiled.text = [NSString stringWithFormat:@"%ld", number];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
