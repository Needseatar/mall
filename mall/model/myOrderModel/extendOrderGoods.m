//
//  extendOrderGoods.m
//  mall
//
//  Created by Mihua on 18/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "extendOrderGoods.h"

@implementation extendOrderGoods


-(void)setValueWithDictionary:(NSDictionary *)dic{
    
    self.buyer_id = dic[@"buyer_id"];
    self.commis_rate = dic[@"commis_rate"];
    self.buyer_id = dic[@"buyer_id"];
    self.gc_id = dic[@"gc_id"];
    self.goods_id = dic[@"goods_id"];
    self.goods_image = dic[@"goods_image"];
    self.goods_image_url = dic[@"goods_image_url"];
    self.goods_name = dic[@"goods_name"];
    self.goods_num = dic[@"goods_num"];
    self.goods_pay_price = dic[@"goods_pay_price"];
    self.goods_price = dic[@"goods_price"];
    self.goods_type = dic[@"goods_type"];
    self.order_id = dic[@"order_id"];
    self.promotions_id = dic[@"promotions_id"];
    self.rec_id = dic[@"rec_id"];
    self.store_id = dic[@"store_id"];
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSArray * arrayData = data[@"extend_order_goods"];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayData.count; i++) {
        extendOrderGoods *extendOrder = [[extendOrderGoods alloc] init];
        [extendOrder setValueWithDictionary:arrayData[i]];
        [mArray addObject:extendOrder];
    }
    return mArray;
}

@end
