//
//  secondStoreList.h
//  mall
//
//  Created by Mihua on 14/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface secondStoreList : NSObject

@property (retain, nonatomic) NSString *all;
@property (retain, nonatomic) NSString *avatar;
@property (retain, nonatomic) NSString *good_percent;
@property (retain, nonatomic) NSString *member_id;
@property (retain, nonatomic) NSString *member_name;
@property (retain, nonatomic) NSString *store_credit;
@property (retain, nonatomic) NSString *store_id;
@property (retain, nonatomic) NSString *store_name;
@property (retain, nonatomic) NSString *store_phone;
@property (retain, nonatomic) NSString *store_qq;
@property (retain, nonatomic) NSString *store_ww;

+(secondStoreList *)setValueWithDictionary:(NSDictionary *)data;

@end
