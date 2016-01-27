//
//  addressAreaModel.m
//  mall
//
//  Created by Mihua on 27/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "addressAreaModel.h"

@implementation addressAreaModel

-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.area_id = dic[@"area_id"];
    self.area_name = dic[@"area_name"];
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary *dic = data[@"datas"];
    NSArray * arrayData = dic[@"area_list"];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayData.count; i++) {
        addressAreaModel *addressList = [[addressAreaModel alloc] init];
        [addressList setValueWithDictionary:arrayData[i]];
        [mArray addObject:addressList];
    }
    return mArray;
}


@end
