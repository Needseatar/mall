//
//  merchantModel.m
//  mall
//
//  Created by Mihua on 6/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "merchantModel.h"


@implementation merchantModel


-(void)setValueWithDictionary:(NSDictionary *)dic
{
    self.store_address = dic[@"store_address"];
    self.store_area_info = dic[@"store_area_info"];
    self.store_id = dic[@"store_id"];
    self.store_name = dic[@"store_name"];
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data
{
    NSDictionary * dicData = data[@"datas"];
    NSArray * array = dicData[@"store_list"];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        merchantModel *mode = [[merchantModel alloc] init];
        [mode setValueWithDictionary:dic];
        [dataArray addObject:mode];
    }
    return dataArray;
}

@end
