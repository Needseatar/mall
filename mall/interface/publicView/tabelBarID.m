//
//  tabelBarID.m
//  mall
//
//  Created by Mihua on 8/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "tabelBarID.h"

@implementation tabelBarID

+(tabelBarID *)shareTabbarID:(UITabBarController *)tabbar;
{
    static tabelBarID *TB;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TB = [[tabelBarID alloc] init];
        TB.tabbarControl = tabbar;
    });
    return TB;
}

@end
