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

@property (retain, nonatomic) NSMutableArray  *order_group_list;
@property (assign, nonatomic) NSInteger hasmore;
@property (retain, nonatomic) NSNumber *page_total;

+(myOrderModelList *)setValueWithDictionary:(NSDictionary *)data;


@end
