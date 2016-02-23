//
//  extendOrderGoods.h
//  mall
//
//  Created by Mihua on 18/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface extendOrderGoods : NSString

@property (retain,nonatomic) NSString *buyer_id;
@property (retain,nonatomic) NSString *commis_rate;
@property (retain,nonatomic) NSString *gc_id;
@property (retain,nonatomic) NSString *goods_id;
@property (retain,nonatomic) NSString *goods_image;
@property (retain,nonatomic) NSString *goods_image_url;
@property (retain,nonatomic) NSString *goods_name;
@property (retain,nonatomic) NSString *goods_num;
@property (retain,nonatomic) NSString *goods_pay_price;
@property (retain,nonatomic) NSString *goods_price;
@property (retain,nonatomic) NSString *goods_type;
@property (retain,nonatomic) NSString *order_id;
@property (retain,nonatomic) NSString *promotions_id;
@property (retain,nonatomic) NSString *rec_id;
@property (retain,nonatomic) NSString *store_id;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;

@end
