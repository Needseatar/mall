//
//  fiveBlockString.h
//  mall
//
//  Created by Mihua on 24/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fiveBlockString : NSString

@property (strong, nonatomic) void (^action)(NSString *string); //需要传回动作的名字的参数

@end
