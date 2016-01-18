//
//  addressInfo.m
//  mall
//
//  Created by Mihua on 14/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "addressInfo.h"

@implementation addressInfo

-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.address = dic[@"address"];
    self.address_id = dic[@"address_id"];
    self.area_id = dic[@"area_id"];
    self.area_info = dic[@"area_info"];
    self.city_id = dic[@"city_id"];
    self.dlyp_id = dic[@"dlyp_id"];
    self.is_default = dic[@"is_default"];
    self.member_id = dic[@"member_id"];
    self.mob_phone = dic[@"mob_phone"];
    self.tel_phone = dic[@"tel_phone"];
    self.true_name = dic[@"true_name"];
}

+(addressInfo *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary * DicData = data[@"address_info"];
    if ([DicData count] != 0) {
        addressInfo *addressData = [[addressInfo alloc] init];
        [addressData setValueWithDictionary:DicData];
        return addressData;
    }
    return nil;
}

@end
