//
//  storeCartGoodsList.h
//  mall
//
//  Created by Mihua on 14/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface storeCartGoodsList : NSObject

@property (retain, nonatomic) NSString *bl_id;
@property (retain, nonatomic) NSString *buyer_id;
@property (assign, nonatomic) NSInteger cart_id;
@property (retain, nonatomic) NSString *gc_id;
@property (retain, nonatomic) NSString *goods_commonid;
@property (retain, nonatomic) NSString *goods_freight;
@property (retain, nonatomic) NSString *goods_id;
@property (retain, nonatomic) NSString *goods_image;
@property (retain, nonatomic) NSString *goods_image_url;
@property (retain, nonatomic) NSString *goods_name;
@property (retain, nonatomic) NSString *goods_num;
@property (retain, nonatomic) NSString *goods_price;
@property (retain, nonatomic) NSString *goods_storage;
@property (retain, nonatomic) NSString *goods_storage_alarm;
@property (retain, nonatomic) NSString *goods_total;
@property (retain, nonatomic) NSString *goods_vat;
@property (retain, nonatomic) NSString *groupbuy_info;
@property (retain, nonatomic) NSString *have_gift;
@property (retain, nonatomic) NSString *is_fcode;
@property (retain, nonatomic) NSString *state;
@property (retain, nonatomic) NSString *storage_state;
@property (retain, nonatomic) NSString *store_id;
@property (retain, nonatomic) NSString *store_name;
@property (retain, nonatomic) NSString *transport_id;
@property (retain, nonatomic) NSString *xianshi_info;


-(void)setValueWithDictionary:(NSDictionary *)dic;
+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;

@end
