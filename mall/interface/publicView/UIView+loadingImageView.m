//
//  UIView+loadingImageView.m
//  mall
//
//  Created by Mihua on 14/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "UIView+loadingImageView.h"

@implementation UIView (loadingImageView)


#pragma mark - 创建加载视图
+(UIView *)setLoadingImageView222:(CGRect )fr;
{
    CGRect bgFrame = fr;
    bgFrame.size.height = fr.size.height+15;
    UIView *vi = [[UIView alloc] init];
    vi.frame = bgFrame;
    
    CGRect frame = fr;
    frame.origin.x=0;
    frame.origin.y=0;
    
    CGRect frame1 = frame;
    frame1.origin.y = fr.size.height;
    frame1.size.height = 15;
    
    static UIImageView *imageView;
    static UIImageView *imageView1;
    static UILabel *label;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageView = [[UIImageView alloc] init];
        imageView1 = [[UIImageView alloc] init];
        label = [[UILabel alloc] init];
    });
    
    
    imageView.frame = frame;
    imageView.image = [UIImage imageNamed:@"load.png"];
    [vi addSubview:imageView];
    
    imageView1.frame = frame;
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
    
    
    label.frame = frame1;
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"正在加载......";
    [vi addSubview:label];
    
    return vi;
}



@end
