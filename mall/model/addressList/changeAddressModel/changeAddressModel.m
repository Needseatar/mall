//
//  changeAddressModel.m
//  mall
//
//  Created by Mihua on 24/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "changeAddressModel.h"

@implementation changeAddressModel


-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.allow_offpay = [dic[@"allow_offpay"] integerValue];
    self.allow_offpay_batch = dic[@"allow_offpay_batch"];
    self.content = dic[@"content"];
    self.offpay_hash = dic[@"offpay_hash"];
    self.offpay_hash_batch = dic[@"offpay_hash_batch"];
    self.state = dic[@"state"];
}

+(changeAddressModel *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary *dic = data[@"datas"];
    changeAddressModel *changAddress = [[changeAddressModel alloc] init];
    [changAddress setValueWithDictionary:dic];
    return changAddress;
}


@end
