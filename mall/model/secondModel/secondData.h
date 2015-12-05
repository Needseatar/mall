//
//  secondData.h
//  mall
//
//  Created by Mihua on 4/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//
/*
 * 1.包含第分类页面的所有数据，第一级数据可以是NSArray，可以通过ID找到对应的第二级的数据，如果id=nil，就是数据请求失败
 *
 * 2.第二级数据是也是NSArray，可以通过id找到第三级的数据，如果id＝nil，就是数据请求失败
 *
 * 3.第三级数据是NSArray，可以通过下标找到对应cell里面的数据，id＝nil
 *
 *
 */


#import <Foundation/Foundation.h>

@interface secondData : NSObject

@property (retain, nonatomic) NSMutableArray *oneArray;

@end
