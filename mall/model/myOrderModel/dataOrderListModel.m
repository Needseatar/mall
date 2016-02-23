//
//  dataOrderListModel.m
//  mall
//
//  Created by Mihua on 17/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "dataOrderListModel.h"

@implementation dataOrderListModel

-(void)setValueWithDictionary:(NSDictionary *)dic{
    
    self.add_time = dic[@"add_time"];
    self.buyer_email = dic[@"buyer_email"];
    self.buyer_id = dic[@"buyer_id"];
    self.buyer_name = dic[@"buyer_name"];
    self.credits = dic[@"credits"];
    self.delay_time = dic[@"delay_time"];
    self.delete_state = dic[@"delete_state"];
    self.evaluation_state = dic[@"evaluation_state"];
    self.extend_order_goods = [extendOrderGoods setValueWithDictionary:dic];
    self.finnshed_time = dic[@"finnshed_time"];
    self.goods_amount = dic[@"goods_amount"];
    self.if_cancel = dic[@"if_cancel"];
    self.if_deliver = dic[@"if_deliver"];
    self.if_lock = dic[@"if_lock"];
    self.if_receive = dic[@"if_receive"];
    self.lock_state = dic[@"lock_state"];
    self.order_amount = dic[@"order_amount"];
    self.order_from = dic[@"order_from"];
    self.order_id = dic[@"order_id"];
    self.order_sn = dic[@"order_sn"];
    self.order_state = dic[@"order_state"];
    self.pay_sn = dic[@"pay_sn"];
    self.payment_code = dic[@"payment_code"];
    self.payment_name = dic[@"payment_name"];
    self.payment_time = dic[@"payment_time"];
    self.pd_amount = dic[@"pd_amount"];
    self.rcb_amount = dic[@"rcb_amount"];
    self.refund_amount = dic[@"refund_amount"];
    self.refund_state = dic[@"refund_state"];
    self.shipping_code = dic[@"shipping_code"];
    self.shipping_fee = dic[@"shipping_fee"];
    self.state_desc = dic[@"state_desc"];
    self.store_id = dic[@"store_id"];
    self.store_name = dic[@"store_name"];
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSArray * arrayData = data[@"order_list"];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    NSMutableArray *storeArrayList = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayData.count; i++) {
        dataOrderListModel *OrderList = [[dataOrderListModel alloc] init];
        [OrderList setValueWithDictionary:arrayData[i]];
        
        //打包数据
        for (int i=0; i<OrderList.extend_order_goods.count; i++) {
            if (i==0) {
                [storeArrayList addObject:OrderList];
            }
            [storeArrayList addObject:OrderList.extend_order_goods[i]];
            if (i==OrderList.extend_order_goods.count-1) {
                [storeArrayList addObject:[NSDictionary dictionaryWithObjectsAndKeys:OrderList, @"foot", nil]];
            }
        }
        
        [mArray addObject:OrderList];
    }
    [mArray addObject:storeArrayList]; //把打包好的数据放在最后一个位置
    
    return mArray;
}

@end
