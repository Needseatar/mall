//
//  fisterList.m
//  mall
//
//  Created by Mihua on 5/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterList.h"

@implementation fisterList

-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.goods_id = dic[@"goods_id"];
    self.goods_image = dic[@"goods_image"];
    self.goods_name = dic[@"goods_name"];
    self.goods_price = dic[@"goods_price"];
    self.goods_promotion_price = dic[@"goods_promotion_price"];
}

+(NSArray *)setValueWithDictionary:(NSDictionary *)data{
    NSArray * arrayData = data[@"item"];
    NSMutableArray *nsMarray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<arrayData.count; i++) {
        fisterList *mode = [[fisterList alloc] init];
        [mode setValueWithDictionary:arrayData[i]];
        [nsMarray addObject:mode];
    }
    return nsMarray;
}

@end
