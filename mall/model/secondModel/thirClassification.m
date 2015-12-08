//
//  thirClassification.m
//  mall
//
//  Created by Mihua on 7/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "thirClassification.h"

@implementation thirClassification

-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.gc_parent_id = [dic[@"gc_id"] integerValue];
    self.gc_name      = dic[@"gc_name"];
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary * dicData = data[@"datas"];
    NSArray * array = dicData[@"class_list"];
    NSMutableArray *dataArray = [NSMutableArray array];
    NSMutableArray *dataThirArray;
    int i=0;
    for (NSDictionary *dic in array) {
        thirClassification *mode = [[thirClassification alloc] init];
        [mode setValueWithDictionary:dic];
        
        //将每个完整的array封装成每三个对象组成一个数组，没有三个小的数组组成一个大数组
        if (i == 0) {
            dataThirArray = [NSMutableArray array];
            [dataThirArray addObject:mode];
            i++;
        }else
        {
            [dataThirArray addObject:mode];
            i++;
        }
        //重置i，并将dataThirArray加入返回的dataArray;
        if (i==3) {
            i=0;
            [dataArray addObject:dataThirArray];
        }
    }
    if (i!=3 && i!=0) {
        [dataArray addObject:dataThirArray];
    }
    return dataArray;
}

@end
