//
//  tabelBarID.h
//  mall
//
//  Created by Mihua on 8/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tabelBarID : NSObject

@property (nonatomic, retain) UITabBarController * tabbarControl;

//单例创建一个tabbarControl的类，保存了tabbarControl的id
+(tabelBarID *)shareTabbarID:(UITabBarController *)tabbar;

@end
