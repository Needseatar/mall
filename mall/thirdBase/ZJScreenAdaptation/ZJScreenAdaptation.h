//
//  ZJScreenAdaptation.h
//  ScreenAdaptationPage
//
//  Created by mac on 15/4/29.
//  Copyright (c) 2015年 zhang jian. All rights reserved.
//

/*
 *  适配
 * 导航和标签栏的height不变
 *
 苹果4s
 width：320.000000
 height：480.000000
 苹果5
 width：320.000000
 height：568.000000
 苹果5s
 width：320.000000
 height：568.000000
 苹果6
 width：375.000000
 height：667.000000
 苹果6 plus
 width：414.000000
 height：736.000000
 苹果6s
 width：375.000000
 height：667.000000
 苹果6s plus
 width：414.000000
 height：736.000000
 
 */

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef enum { //传递导航栏的样式
    changeWidth=1,  //长会变
    changeX=2,   //x坐标位置会变
    noChange=3  //都不变
}CGChange;

#define CGRectMakeEx(x,y,width,height) CGRectMakeAdaptation(x, y, width, height)

#define CGRectMakeNavigationEx(x, y, width, height, style) CGRectMakeNavigation(x, y, width, height, style)

#define CGSizeMakeEx(width,height) CGSizeMakeAdaptation(width, height)
#define widthEx(width)  widthAdaptation(width)
#define heightEx(height) heightAdaptation(height)

@interface ZJScreenAdaptation : NSObject
//扩展函数适配Rect
CGRect CGRectMakeAdaptation(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

CGRect  CGRectMakeNavigation(CGFloat x, CGFloat y, CGFloat width, CGFloat height, CGChange style);

//扩展适应Size
CGSize CGSizeMakeAdaptation(CGFloat width, CGFloat height);
//适配高度
double heightAdaptation(double height);
//适配宽度
double widthAdaptation(double width);
@end
