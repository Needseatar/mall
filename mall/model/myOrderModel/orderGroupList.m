//
//  orderGroupList.m
//  mall
//
//  Created by Mihua on 16/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "orderGroupList.h"

@implementation orderGroupList

-(void)setValueWithDictionary:(NSDictionary *)dic{
    
    self.add_time = dic[@"add_time"];
    self.order_list = dic[@"order_list"];
    self.pay_amount = dic[@"pay_amount"];
    self.pay_sn = dic[@"pay_sn"];
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSArray * arrayData = data[@"order_group_list"];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayData.count; i++) {
        orderGroupList *voiceList = [[orderGroupList alloc] init];
        [voiceList setValueWithDictionary:arrayData[i]];
        [mArray addObject:voiceList];
    }
    return mArray;
}


@end
