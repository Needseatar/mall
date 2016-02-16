//
//  myOrderModel.m
//  mall
//
//  Created by Mihua on 16/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "myOrderModel.h"

@implementation myOrderModel

-(void)setValueWithDictionary:(NSDictionary *)dic{
    
    self.order_group_list = dic[@"order_group_list"];
    self.hasmore = dic[@"hasmore"];
    self.page_total = dic[@"page_total"];
}

+(myOrderModel *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary *dic = data[@"datas"];
    myOrderModel *model = [[myOrderModel alloc] init];
    [model setValueWithDictionary:dic];
    return model;
}


@end
