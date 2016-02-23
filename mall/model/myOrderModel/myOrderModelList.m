//
//  myOrderModel.m
//  mall
//
//  Created by Mihua on 16/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "myOrderModelList.h"

@implementation myOrderModelList

+(myOrderModelList *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary *dic = data[@"datas"];
    myOrderModelList *model = [[myOrderModelList alloc] init];
    model.order_group_list = [orderGroupList setValueWithDictionary:dic];
    model.hasmore = data[@"hasmore"];
    model.page_total = data[@"page_total"];
    return model;
}

@end
