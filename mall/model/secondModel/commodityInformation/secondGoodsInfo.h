//
//  secondGoodsInfo.h
//  mall
//
//  Created by Mihua on 14/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface secondGoodsInfo : NSObject

@property (retain, nonatomic) NSString *appoint_satedate;
@property (retain, nonatomic) NSString *areaid_1;
@property (retain, nonatomic) NSString *areaid_2;
@property (retain, nonatomic) NSString *color_id;
@property (retain, nonatomic) NSString *evaluation_count;
@property (retain, nonatomic) NSString *evaluation_good_star;
@property (retain, nonatomic) NSString *gc_id_1;
@property (retain, nonatomic) NSString *gc_id_2;
@property (retain, nonatomic) NSString *gc_id_3;
@property (retain, nonatomic) NSString *goods_attr;
@property (retain, nonatomic) NSString *goods_click;
@property (retain, nonatomic) NSString *goods_collect;
@property (retain, nonatomic) NSString *goods_costprice;
@property (retain, nonatomic) NSString *goods_discount;
@property (retain, nonatomic) NSString *goods_freight;
@property (retain, nonatomic) NSString *goods_id;
@property (retain, nonatomic) NSString *goods_jingle;
@property (retain, nonatomic) NSString *goods_marketprice;
@property (retain, nonatomic) NSString *goods_name;
@property (retain, nonatomic) NSString *goods_price;
@property (retain, nonatomic) NSString *goods_promotion_price;
@property (retain, nonatomic) NSString *goods_promotion_type;
@property (retain, nonatomic) NSString *goods_salenum;
@property (retain, nonatomic) NSString *goods_serial;
@property (retain, nonatomic) NSString *goods_spec;
@property (retain, nonatomic) NSString *goods_specname;
@property (retain, nonatomic) NSString *goods_stcids;
@property (retain, nonatomic) NSString *goods_storage;
@property (retain, nonatomic) NSString *goods_storage_alarm;
@property (retain, nonatomic) NSString *goods_url;
@property (retain, nonatomic) NSString *goods_vat;
@property (retain, nonatomic) NSString *groupbuy_info;
@property (retain, nonatomic) NSString *have_gift;
@property (retain, nonatomic) NSString *is_appoint;
@property (retain, nonatomic) NSString *is_fcode;
@property (retain, nonatomic) NSString *is_own_shop;
@property (retain, nonatomic) NSString *is_presell;
@property (retain, nonatomic) NSString *is_virtual;
@property (retain, nonatomic) NSString *mobile_body;
@property (retain, nonatomic) NSString *plateid_bottom;
@property (retain, nonatomic) NSString *plateid_top;
@property (retain, nonatomic) NSString *presell_deliverdate;
@property (retain, nonatomic) NSDictionary *spec_name;
@property (retain, nonatomic) NSDictionary *spec_value;
@property (retain, nonatomic) NSString *transport_id;
@property (retain, nonatomic) NSString *transport_title;
@property (retain, nonatomic) NSString *virtual_indate;
@property (retain, nonatomic) NSString *virtual_invalid_refund;
@property (retain, nonatomic) NSString *virtual_limit;
@property (retain, nonatomic) NSString *xianshi_info;


+(secondGoodsInfo *)setValueWithDictionary:(NSDictionary *)data;

@end
