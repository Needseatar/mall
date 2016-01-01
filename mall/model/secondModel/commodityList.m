//
//  commodityList.m
//  mall
//
//  Created by Mihua on 10/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "commodityList.h"

@implementation commodityList

-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.evaluation_count = [NSString stringWithFormat:@"%@", dic[@"evaluation_count"]];
    self.evaluation_good_star = dic[@"evaluation_good_star"];
    self.goods_id = dic[@"goods_id"];
    self.goods_image = dic[@"goods_image"];
    self.goods_image_url = dic[@"goods_image_url"];
    self.goods_marketprice = dic[@"goods_marketprice"];
    self.goods_name = dic[@"goods_name"];
    self.goods_price = dic[@"goods_price"];
    self.goods_salenum = dic[@"goods_salenum"];
    self.have_gift   = dic[@"have_gift"];
    self.is_fcode  = dic[@"is_fcode"];
    self.is_presell = dic[@"is_presell"];
    self.is_virtual = dic[@"is_virtual"];
    self.xianshi_flag = dic[@"xianshi_flag"];
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary * dicData = data[@"datas"];
    NSArray * array = dicData[@"goods_list"];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        commodityList *mode = [[commodityList alloc] init];
        [mode setValueWithDictionary:dic];
        [dataArray addObject:mode];
    }
    return dataArray;
}

@end
