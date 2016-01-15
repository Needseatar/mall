//
//  storeCartGoodsList.m
//  mall
//
//  Created by Mihua on 14/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "storeCartGoodsList.h"

@implementation storeCartGoodsList


-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.bl_id = dic[@"bl_id"];
    self.buyer_id = dic[@"buyer_id"];
    self.cart_id = dic[@"cart_id"];
    self.gc_id = dic[@"gc_id"];
    self.goods_commonid = dic[@"goods_commonid"];
    self.goods_freight = dic[@"goods_freight"];
    self.goods_id = dic[@"goods_id"];
    self.goods_image = dic[@"goods_image"];
    self.goods_image_url = dic[@"goods_image_url"];
    self.goods_name = dic[@"goods_name"];
    self.goods_num = dic[@"goods_num"];
    self.goods_price = dic[@"goods_price"];
    self.goods_storage = dic[@"goods_storage"];
    self.goods_storage_alarm = dic[@"goods_storage_alarm"];
    self.goods_total = dic[@"goods_total"];
    self.goods_vat = dic[@"goods_vat"];
    self.groupbuy_info = dic[@"groupbuy_info"];
    self.have_gift = dic[@"have_gift"];
    self.is_fcode = dic[@"is_fcode"];
    self.state = dic[@"state"];
    self.storage_state = dic[@"storage_state"];
    self.store_id = dic[@"store_id"];
    self.store_name = dic[@"store_name"];
    self.transport_id = dic[@"transport_id"];
    self.bl_id = dic[@"xianshi_info"];
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSArray * arrayData = data[@"goods_list"];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayData.count; i++) {
        storeCartGoodsList *storeCart = [[storeCartGoodsList alloc] init];
        [storeCart setValueWithDictionary:arrayData[i]];
        [mArray addObject:storeCart];
    }
    return mArray;
}


@end
