//
//  storeCartInformaton.m
//  mall
//
//  Created by Mihua on 15/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "storeCartInformaton.h"

@implementation storeCartInformaton


-(void)setValueWithDictionary:(NSDictionary *)dic
{
    self.freight = dic[@"freight"];
    self.store_goods_total = dic[@"store_goods_total"];
    self.store_mansong_rule_list = dic[@"store_mansong_rule_list"];
    self.store_name = dic[@"store_name"];
    self.store_voucher_list = dic[@"store_voucher_list"];
    
    self.goods_list = [storeCartGoodsList setValueWithDictionary:dic];
    
}
+(NSArray *)setValueWithDictionary:(NSDictionary *)data
{
    NSDictionary *dataDic = data[@"store_cart_list"];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dataDic) {
        storeCartInformaton *store = [[storeCartInformaton alloc] init];
        NSLog(@"%@", dataDic[dic]);
        [store setValueWithDictionary:dataDic[dic]];
        [mArray addObject:store];
    }
    
    return mArray;
}


@end
