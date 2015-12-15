//
//  dataCommodityInformation.m
//  mall
//
//  Created by Mihua on 14/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "dataCommodityInformation.h"

@implementation dataCommodityInformation

-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.goods_commend_list = [secondCommendList setValueWithDictionary:dic];
    self.goods_image = dic[@"goods_image"];
    self.goods_info = [secondGoodsInfo setValueWithDictionary:dic];
    self.spec_image = dic[@"spec_image"];
    self.spec_list = dic[@"spec_list"];
    self.store_info = dic[@"store_info"];
}

+(dataCommodityInformation *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary * dicData = data[@"datas"];
    dataCommodityInformation *DCInformation = [[dataCommodityInformation alloc] init];
    [DCInformation setValueWithDictionary:dicData];
    return DCInformation;
}

@end
