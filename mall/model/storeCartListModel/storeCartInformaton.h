//
//  storeCartInformaton.h
//  mall
//
//  Created by Mihua on 15/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "storeCartGoodsList.h"

@interface storeCartInformaton : NSObject


@property (retain, nonatomic) NSString *freight;
@property (retain, nonatomic) NSArray  *goods_list;
@property (retain, nonatomic) NSString *store_goods_total;
@property (retain, nonatomic) NSString *store_mansong_rule_list;
@property (retain, nonatomic) NSString *store_name;
@property (retain, nonatomic) NSString *store_voucher_list;


-(void)setValueWithDictionary:(NSDictionary *)dic;
+(NSArray *)setValueWithDictionary:(NSDictionary *)data;

@end
