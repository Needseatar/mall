//
//  myOrderModel.h
//  mall
//
//  Created by Mihua on 16/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "orderGroupList.h"

@interface myOrderModelList : NSString

@property (retain, nonatomic) NSArray  *order_group_list;
@property (retain, nonatomic) NSNumber *hasmore;
@property (retain, nonatomic) NSNumber *page_total;

+(myOrderModelList *)setValueWithDictionary:(NSDictionary *)data;


@end
