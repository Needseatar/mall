//
//  fisterData.m
//  mall
//
//  Created by Mihua on 5/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterData.h"

@implementation fisterData

//加载home1和home4
-(void)setValueWithDictionary:(NSDictionary *)dic{
    [self.FHome addObject:[fisterHome1 setValueWithDictionary:dic[@"home1"]]];
    [self.FHome addObject:dic[@"home4"]];
}
-(void)setValueWithDictionary:(NSDictionary *)dic{
    
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
