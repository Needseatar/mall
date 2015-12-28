//
//  ZJScreenAdaptation.m
//  ScreenAdaptationPage
//
//  Created by mac on 15/4/29.
//  Copyright (c) 2015年 zhang jian. All rights reserved.
//


/*
 *以5和5s 作为参考坐标
 *
 */

#import "ZJScreenAdaptation.h"

@implementation ZJScreenAdaptation
static double autoSizeScaleX;
static double autoSizeScaleY;
//此方法在类加载的时候执行
+ (void)load;
{
    //NSLog(@"ZJScreenAdaptation load");
    
    //获取屏幕大小
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    //苹果4s
    if (size.height == 480) {
        autoSizeScaleX = 1.0;
        autoSizeScaleY = (float)size.height/568.0;
    }else if(size.height == 568) //苹果5或者5s
    {
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }else //苹果6或者6s //苹果6plus或者6s plus
    {
        autoSizeScaleX = (float)size.width/320.0;
        autoSizeScaleY = (float)size.height/568.0;
    }
}
CGRect CGRectMakeAdaptation(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}
CGRect CGRectMakeNavigation(CGFloat x, CGFloat y, CGFloat width, CGFloat height, CGChange style)
{
    CGRect rect;
    if (style == changeWidth) {
        rect.origin.x = x;
        rect.origin.y = y;
        rect.size.width = width * autoSizeScaleX;
        rect.size.height = height;
    }else if(style == changeX)
    {
        rect.origin.x = x * autoSizeScaleX;
        rect.origin.y = y;
        rect.size.width = width;
        rect.size.height = height;
    }else
    {
        rect.origin.x = x;
        rect.origin.y = y;
        rect.size.width = width;
        rect.size.height = height;
    }
    return rect;
}
CGSize CGSizeMakeAdaptation(CGFloat width, CGFloat height)
{
    CGSize size;
    size.width = autoSizeScaleX * width;
    size.height = autoSizeScaleY * height;
    return size;
}
//适配高度
double heightAdaptation(double height)
{
    return height * autoSizeScaleY;
}
//适配宽度
double widthAdaptation(double width)
{
    return width * autoSizeScaleX;
}
@end
