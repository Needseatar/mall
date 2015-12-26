//
//  secondGoodsInfo.m
//  mall
//
//  Created by Mihua on 14/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "secondGoodsInfo.h"

@implementation secondGoodsInfo

-(void)setValueWithDictionary:(NSDictionary *)dic{

    self.appoint_satedate = dic[@"appoint_satedate"];
    self.areaid_1  = dic[@"areaid_1"];
    self.areaid_2 = dic[@"areaid_2"];
    self.color_id = dic[@"color_id"];
    self.evaluation_count = dic[@"evaluation_count"];
    self.evaluation_good_star = dic[@"evaluation_good_star"];
    self.gc_id_1 = dic[@"gc_id_1"];
    self.gc_id_2 = dic[@"gc_id_2"];
    self.gc_id_3 = dic[@"gc_id_3"];
    self.goods_attr = dic[@"goods_attr"];
    self.goods_click = dic[@"goods_click"];
    self.goods_collect = dic[@"goods_collect"];
    self.goods_costprice = dic[@"goods_costprice"];
    self.goods_discount = dic[@"goods_discount"];
    self.goods_freight = dic[@"goods_freight"];
    self.goods_id = dic[@"goods_id"];
    self.goods_jingle = dic[@"goods_jingle"];
    self.goods_marketprice = dic[@"goods_marketprice"];
    self.goods_name = dic[@"goods_name"];
    self.goods_price = dic[@"goods_price"];
    self.goods_promotion_price = dic[@"goods_promotion_price"];
    self.goods_promotion_type = dic[@"goods_promotion_type"];
    self.goods_salenum = dic[@"goods_salenum"];
    self.goods_serial = dic[@"goods_serial"];
    self.goods_spec = dic[@"goods_spec"];
    self.goods_specname = dic[@"goods_specname"];
    self.goods_stcids = dic[@"goods_stcids"];
    self.goods_storage = dic[@"goods_storage"];
    self.goods_storage_alarm = dic[@"goods_storage_alarm"];
    self.goods_url = dic[@"goods_url"];
    self.goods_vat = dic[@"goods_vat"];
    self.groupbuy_info = dic[@"groupbuy_info"];
    self.have_gift = dic[@"have_gift"];
    self.is_appoint = dic[@"is_appoint"];
    self.is_fcode = dic[@"is_fcode"];
    self.is_own_shop = dic[@"is_own_shop"];
    self.is_presell = dic[@"is_presell"];
    self.is_virtual = dic[@"is_virtual"];
    self.mobile_body = dic[@"mobile_body"];
    self.plateid_bottom = dic[@"plateid_bottom"];
    self.plateid_top = dic[@"plateid_top"];
    self.presell_deliverdate = dic[@"presell_deliverdate"];
    self.spec_name = dic[@"spec_name"];
    self.spec_value = dic[@"spec_value"];
    self.transport_id = dic[@"transport_id"];
    self.transport_title = dic[@"transport_title"];
    self.virtual_indate = dic[@"virtual_indate"];
    self.virtual_invalid_refund = dic[@"virtual_invalid_refund"];
    self.virtual_limit = dic[@"virtual_limit"];
    self.xianshi_info = dic[@"xianshi_info"];
    
}

+(secondGoodsInfo *)setValueWithDictionary:(NSDictionary *)data{
    secondGoodsInfo *mode = [[secondGoodsInfo alloc] init];
    [mode setValueWithDictionary:data[@"goods_info"]];
    return mode;
}


@end
