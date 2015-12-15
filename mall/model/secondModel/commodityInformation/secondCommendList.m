//
//  secondCommendList.m
//  mall
//
//  Created by Mihua on 14/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "secondCommendList.h"

@implementation secondCommendList

-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.goods_id = dic[@"goods_id"];
    self.goods_image_url   = dic[@"goods_image_url"];
    self.goods_name = dic[@"goods_name"];
    self.goods_price = dic[@"goods_price"];
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSArray * array = data[@"goods_commend_list"];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        secondCommendList *mode = [[secondCommendList alloc] init];
        [mode setValueWithDictionary:dic];
        [dataArray addObject:mode];
    }
    return dataArray;
}


@end
