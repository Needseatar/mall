//
//  shopingCarModel.m
//  mall
//
//  Created by Mihua on 6/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "shopingCarModel.h"

@implementation shopingCarModel

-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.bl_id = dic[@"bl_id"];
    self.buyer_id  = dic[@"buyer_id"];
    self.cart_id  = dic[@"cart_id"];
    self.goods_id  = dic[@"goods_id"];
    self.goods_image  = dic[@"goods_image"];
    self.goods_image_url  = dic[@"goods_image_url"];
    self.goods_name  = dic[@"goods_name"];
    self.goods_num  = dic[@"goods_num"];
    self.goods_price  = dic[@"goods_price"];
    self.goods_sum  = dic[@"goods_sum"];
    self.store_id  = dic[@"store_id"];
    self.store_name = dic[@"store_name"];
    
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary * dicData = data[@"datas"];
    NSArray * array = dicData[@"cart_list"];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        shopingCarModel *mode = [[shopingCarModel alloc] init];
        [mode setValueWithDictionary:dic];
        [dataArray addObject:mode];
    }
    return dataArray;
}


@end
