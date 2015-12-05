//
//  oneClassification.m
//  mall
//
//  Created by Mihua on 30/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "oneClassification.h"

@implementation oneClassification


-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.gc_parent_id = [dic[@"gc_id"] integerValue];
    self.gc_name      = dic[@"gc_name"];
    self.downID       = nil;
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary * dicData = data[@"datas"];
    NSArray * array = dicData[@"class_list"];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        oneClassification *mode = [[oneClassification alloc] init];
        [mode setValueWithDictionary:dic];
        [dataArray addObject:mode];
    }
    return dataArray;
}

@end
