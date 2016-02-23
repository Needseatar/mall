//
//  orderGroupList.h
//  mall
//
//  Created by Mihua on 16/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dataOrderListModel.h"

@interface orderGroupList : NSString

@property (retain, nonatomic) NSString *add_time;
@property (retain, nonatomic) NSArray  *order_list;
@property (retain, nonatomic) NSString *pay_amount;
@property (retain, nonatomic) NSString *pay_sn;


@property (retain, nonatomic) NSArray  *packArray; //打包数据，把商店下面的商品打包放在商店同一个等级的array里面

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;


@end
