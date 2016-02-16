//
//  secondTwoTableViewCell.m
//  mall
//
//  Created by Mihua on 3/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "secondTwoTableViewCell.h"


@interface secondTwoTableViewCell ()

@property (retain, nonatomic) UIView         *bgView;
@property (retain, nonatomic) NSMutableArray *colorArray;
@property (assign, nonatomic) int            squareWithHeight;

@end

@implementation secondTwoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        _squareWithHeight = ((delegate.ViewFrame.size.width-fisterTabelWith) - 6)/3.0 - 6;
        
        //初始化背景视图
        self.bgView = [[UIView alloc] init];
        self.bgView.frame = CGRectMake(0, 0, delegate.ViewFrame.size.width-fisterTabelWith, 70);
        self.bgView.userInteractionEnabled =YES;
        [self addSubview:self.bgView];
        
        //初始化颜色
        self.colorArray = [[NSMutableArray alloc] init];
        [self.colorArray addObject:[UIColor colorWithRed:248.0f/255.0f green:68.0f/255.0f blue:98.0f/255.0f alpha:1]];
        [self.colorArray addObject:[UIColor colorWithRed:68.0f/255.0f green:188.0f/255.0f blue:248.0f/255.0f alpha:1]];
        [self.colorArray addObject:[UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:128.0f/255.0f alpha:1]];
        [self.colorArray addObject:[UIColor colorWithRed:218.0f/255.0f green:68.0f/255.0f blue:248.0f/255.0f alpha:1]];
        [self.colorArray addObject:[UIColor colorWithRed:248.0f/255.0f green:128.0f/255.0f blue:68.0f/255.0f alpha:1]];
        [self.colorArray addObject:[UIColor colorWithRed:128.0f/255.0f green:68.0f/255.0f blue:248.0f/255.0f alpha:1]];
        
        
        //初始化cell里面的格子
        for (int i=0; i<3; i++) {
            squareLabel *SLabel = [[squareLabel alloc] init]; //squareLabel继承于label，增加了一个nsinter属性保存方块的id
            SLabel.frame = CGRectMake(6 + i*(_squareWithHeight+6), 6, _squareWithHeight, _squareWithHeight);
            [SLabel setBackgroundColor:[UIColor redColor]];
            [SLabel setTextAlignment:NSTextAlignmentCenter];
            [SLabel setTextColor:[UIColor whiteColor]];
            SLabel.numberOfLines = 3;
            SLabel.tag = i+50;
            UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionOflabel:)];//加载点击动作
            [SLabel addGestureRecognizer:tapAction];
            SLabel.userInteractionEnabled = YES;
            [self.bgView addSubview:SLabel];
        }
    }
    return self;
}

-(void)settextLabel:(NSArray *)data
{
    //洗白
    for (int i=0; i<3; i++) {
        squareLabel *SLabel = (squareLabel *)[self.bgView viewWithTag:50+i];
        [SLabel setBackgroundColor:[UIColor clearColor]];
        SLabel.text = @"";
        SLabel.gc_parent_id = 0;
        SLabel.userInteractionEnabled = NO;
    }
    if (data.count != 0 && data.count<4) {
        for (int i=0; i<data.count; i++) {
            squareLabel *SLabel = (squareLabel *)[self.bgView viewWithTag:50+i];
            SLabel.userInteractionEnabled = YES;
            thirClassification *stringObj = data[i];
            int color = arc4random() % 5;
            [SLabel setBackgroundColor:self.colorArray[color]];
            SLabel.text = stringObj.gc_name;
            SLabel.gc_parent_id = stringObj.gc_parent_id;
        }
    }
    
}
//点击操作
-(void)tapActionOflabel:(UITapGestureRecognizer *)tapAction
{
    squareLabel *SLabel = (squareLabel *)tapAction.view;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"squareStringID" object:[NSString stringWithFormat:@"%ld", (long)SLabel.gc_parent_id]];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
