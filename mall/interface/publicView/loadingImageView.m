//
//  loadingImageView.m
//  mall
//
//  Created by Mihua on 29/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "loadingImageView.h"

@implementation loadingImageView

+(UIView *)setLoadingImageView:(CGRect )fr
{
    CGRect bgFrame = fr;
    bgFrame.size.height = fr.size.height+15;
    UIView *vi = [[UIView alloc] init];
    vi.frame = bgFrame;
    
    CGRect frame = fr;
    frame.origin.x=0;
    frame.origin.y=0;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = frame;
    imageView.image = [UIImage imageNamed:@"load.png"];
    [vi addSubview:imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:frame];
    imageView1.image = [UIImage imageNamed:@"dialog_bocop_loading_rotate_anim_img.png"];
    [vi addSubview:imageView1];
    
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //2.设置动画属性初始值、结束值
    basicAnimation.toValue=[NSNumber numberWithFloat:4*M_PI_2];
    basicAnimation.repeatCount=HUGE_VALF;//设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效
    //设置其他动画属性
    basicAnimation.duration=2;  //动画时间
    basicAnimation.autoreverses=NO;//旋转后再旋转到原来的位置
    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [imageView1.layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
    
    CGRect frame1 = frame;
    frame1.origin.y = fr.size.height;
    frame1.size.height = 15;
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame1;
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"正在加载......";
    [vi addSubview:label];
    
    return vi;
}

+(UIView *)setNetWorkError:(CGRect )fr
{
    UIView *vi = [[UIView alloc] init];
    vi.frame = fr;
    
    CGRect fram = fr;
    fram.origin.y = 0;
    fram.origin.x = fr.size.width/2.0 - (fr.size.width/2.0)/2.0;
    fram.size.width = fr.size.width/2.0;
    fram.size.height = fr.size.width/2.0;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:fram];
    [imageView setImage:[UIImage imageNamed:@"wifi_off.png"]];
    [vi addSubview:imageView];
    
    fram = fr;
    fram.origin.y = imageView.frame.size.height;
    fram.origin.x = imageView.frame.origin.x;
    fram.size.width = imageView.frame.size.height;
    fram.size.height = 20;
    UILabel *label = [[UILabel alloc] initWithFrame:fram];
    label.text = @"网络开了小差";
    label.textAlignment = NSTextAlignmentCenter;
    [vi addSubview:label];
    
    fram = fr;
    fram.origin.y = label.frame.origin.y+label.frame.size.height;
    fram.origin.x = 0;
    fram.size.width = fr.size.width;
    fram.size.height = 50;
    UILabel *label1 = [[UILabel alloc] initWithFrame:fram];
    label1.numberOfLines = 2;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"连接不上网络,请确认一下你的网络开关,或者服务器网络正忙,请稍后再试";
    [vi addSubview:label1];
    
    fram = fr;
    fram.origin.y = label1.frame.origin.y+label1.frame.size.height;
    fram.origin.x = fr.size.width/2.0-70/2.0;
    fram.size.width = 70;
    fram.size.height = 30;
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = fram;
    [but setTitle:@"重新连接" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    but.tag = 7777;
    [but setBackgroundColor:[UIColor orangeColor]];
    [vi addSubview:but];
    
    return vi;
}

+(UILabel *)setNetWorkRefreshError:(CGRect )fr viewString:(NSString *)string;
{
    //计算label的长度
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20]};
    CGSize titleSize = [string boundingRectWithSize:CGSizeMake(800, 30) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    CGRect frame = fr;
    frame.size = titleSize;
    frame.size.width = frame.size.width+20;
    frame.origin.x = fr.size.width/2.0 - frame.size.width/2.0;
    frame.origin.y = heightEx(470);
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.7;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:20];
    label.text = string;
    
    return label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
