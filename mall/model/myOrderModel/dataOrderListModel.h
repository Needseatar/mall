//
//  dataOrderListModel.h
//  mall
//
//  Created by Mihua on 17/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "extendOrderGoods.h"

@interface dataOrderListModel : NSString

@property (retain, nonatomic) NSString *add_time;
@property (retain, nonatomic) NSString *buyer_email;
@property (retain, nonatomic) NSString *buyer_id;
@property (retain, nonatomic) NSString *buyer_name;
@property (retain, nonatomic) NSString *credits;
@property (retain, nonatomic) NSString *delay_time;
@property (retain, nonatomic) NSString *delete_state;
@property (retain, nonatomic) NSString *evaluation_state;
@property (retain, nonatomic) NSArray  *extend_order_goods;
@property (retain, nonatomic) NSString *finnshed_time;
@property (retain, nonatomic) NSString *goods_amount;
@property (retain, nonatomic) NSString *if_cancel;
@property (retain, nonatomic) NSString *if_deliver;
@property (retain, nonatomic) NSString *if_lock;
@property (retain, nonatomic) NSString *if_receive;
@property (retain, nonatomic) NSString *lock_state;
@property (retain, nonatomic) NSString *order_amount;
@property (retain, nonatomic) NSString *order_from;
@property (retain, nonatomic) NSString *order_id;
@property (retain, nonatomic) NSString *order_sn;
@property (retain, nonatomic) NSString *order_state;
@property (retain, nonatomic) NSString *pay_sn;
@property (retain, nonatomic) NSString *payment_code;
@property (retain, nonatomic) NSString *payment_name;
@property (retain, nonatomic) NSString *payment_time;
@property (retain, nonatomic) NSString *pd_amount;
@property (retain, nonatomic) NSString *rcb_amount;
@property (retain, nonatomic) NSString *refund_amount;
@property (retain, nonatomic) NSString *refund_state;
@property (retain, nonatomic) NSString *shipping_code;
@property (retain, nonatomic) NSString *shipping_fee;
@property (retain, nonatomic) NSString *state_desc;
@property (retain, nonatomic) NSString *store_id;
@property (retain, nonatomic) NSString *store_name;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;


@end
