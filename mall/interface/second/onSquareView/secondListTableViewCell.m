//
//  secondListTableViewCell.m
//  mall
//
//  Created by Mihua on 11/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "secondListTableViewCell.h"

@interface secondListTableViewCell ()

@property (retain, nonatomic) UIImageView *leftImage;
@property (retain, nonatomic) UILabel     *titlelabel;
@property (retain, nonatomic) UILabel     *pacelabel;
@property (retain, nonatomic) UIView      *bgStarView;
@property (retain, nonatomic) UILabel     *countPeople;


@end

@implementation secondListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //左边图片
        self.leftImage = [[UIImageView alloc] initWithFrame:CGRectMakeEx(5, 5, 90, 95)];
        [self.leftImage setBackgroundColor:[UIColor colorWithRed:223.0/255.0f green:223.0/255.0f blue:223.0/255.0f alpha:1]];
        [self addSubview:self.leftImage];
        
        //右边上标题
        self.titlelabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(90, 3, 225, 50)];
        self.titlelabel.numberOfLines = 2;
        self.titlelabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titlelabel];
        
        //右边价格
        self.pacelabel = [[UILabel alloc] initWithFrame:CGRectMakeEx(90, 53, 225, 25)];
        self.pacelabel.textColor = [UIColor redColor];
        self.pacelabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.pacelabel];
        
        //星星评价
        self.bgStarView = [[UIView alloc] initWithFrame:CGRectMakeEx(90, 81, 225, 26)];
        self.bgStarView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgStarView];
        for (int i=0; i<5; i++) {
            UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMakeEx(28*i, 0, 26, 26)];
            star.tag = 110+i;
            [star setImage:[UIImage imageNamed:@"product_detail_new_collect.png"]];
            [self.bgStarView addSubview:star];
        }
        
        //评价数
        self.countPeople = [[UILabel alloc] initWithFrame:CGRectMakeEx(140, 0, 225-140, 23)];
        self.countPeople.backgroundColor = [UIColor clearColor];
        [self.bgStarView addSubview:self.countPeople];
    }
    return self;
}

-(void)setTextImage:(commodityList *)data
{
    //洗白
    [self.leftImage setBackgroundColor:[UIColor colorWithRed:223.0/255.0f green:223.0/255.0f blue:223.0/255.0f alpha:1]];
    self.titlelabel.text = @"";
    self.pacelabel.text = @"";
    self.countPeople.text = @"";
    for (int i=0; i<5; i++) {
        UIImageView *star = [self.bgStarView viewWithTag:i+110];
        [star setImage:[UIImage imageNamed:@"product_detail_new_collect.png"]];
    }
    
    //加载字体
    [self.leftImage setImageWithURL:[NSURL URLWithString:data.goods_image_url]];
    self.titlelabel.text = data.goods_name;
    self.pacelabel.text  = data.goods_price;
    self.countPeople.text = [NSString stringWithFormat:@"(%@人)", data.evaluation_count];
    
    //加载星星评价数
    float starFLOAT = [data.evaluation_good_star floatValue];
    NSInteger starINT = [data.evaluation_good_star integerValue];
    if (starFLOAT >= (float)starINT) {
        NSLog(@"%ld", starINT);
        for (int i=0; i<starINT; i++) {
            UIImageView *star = [self.bgStarView viewWithTag:i+110];
            [star setImage:[UIImage imageNamed:@"product_detail_new_collect_pressed.png"]];
        }
        if (starFLOAT > (float)starINT) {
            //加载半星
            UIImageView *halfStar = [[UIImageView alloc] initWithFrame:CGRectMakeEx((starINT)*28, 0, 26/2, 26)];
            
             //截一半的星星
            /*首先创建一个一半图片宽度的图形上下文，然后将图片左上角原点移动到与图形上下文负X坐标对齐，从而让图片只有右半部分与图形上下文相交。
             */
            UIImage *img = [UIImage imageNamed:@"product_detail_new_collect_pressed.png"];
            CGSize sz = [img size];
            UIGraphicsBeginImageContextWithOptions(CGSizeMakeEx(sz.width/2.0, sz.height), NO, 0);
            [img drawAtPoint:CGPointMake(0, 0)];
            UIImage* starImg = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext(); //关闭上下文
            [halfStar setImage:starImg];
            
            [self.bgStarView addSubview:halfStar];
        }
    }
}



//UIImageView *view = [[UIImageView alloc]initWithImage:[self getImageWithView:self.view]];
//tesxtImageView.image = view.image;

//得到截取图片的方法
- (UIImage *)getImageWithView:(UIView *)view {
    //此处的CGSizeMake是根据需要制定截取图片的宽、高；NO/YES表示是否透明
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(widthEx(26), heightEx(26)), NO, 1.0);  //NO，YES 控制是否透明
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();    // 生成后的image
    return image;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
