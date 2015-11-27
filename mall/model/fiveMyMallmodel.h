//
//  fiveMyMallmodel.h
//  mall
//
//  Created by Mihua on 27/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fiveMyMallmodel : NSObject

@property (strong, nonatomic) NSString *available_rc_balance;
@property (strong, nonatomic) NSString *avator;
@property (strong, nonatomic) NSString *point;
@property (strong, nonatomic) NSString *predepoit;
@property (strong, nonatomic) NSString *user_name;


+(fiveMyMallmodel *)setUserMall:(NSDictionary *)dic;

@end
