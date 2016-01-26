//
//  addressListModel.m
//  mall
//
//  Created by Mihua on 26/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "addressListModel.h"

@implementation addressListModel

-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.address = [NSString stringWithFormat:@"%@", dic[@"address"]];
    self.address_id = [NSString stringWithFormat:@"%@", dic[@"address_id"]];
    self.area_id = [NSString stringWithFormat:@"%@", dic[@"area_id"]];
    self.area_info = [NSString stringWithFormat:@"%@", dic[@"area_info"]];
    self.city_id = [NSString stringWithFormat:@"%@", dic[@"city_id"]];
    self.dlyp_id = [NSString stringWithFormat:@"%@", dic[@"dlyp_id"]];
    self.is_default = [NSString stringWithFormat:@"%@", dic[@"is_default"]];
    self.member_id = [NSString stringWithFormat:@"%@", dic[@"member_id"]];
    self.mob_phone = [NSString stringWithFormat:@"%@", dic[@"mob_phone"]];
    self.tel_phone = [NSString stringWithFormat:@"%@", dic[@"tel_phone"]];
    self.true_name = [NSString stringWithFormat:@"%@", dic[@"true_name"]];
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary *dic = data[@"datas"];
    NSArray * arrayData = dic[@"address_list"];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayData.count; i++) {
        addressListModel *addressList = [[addressListModel alloc] init];
        [addressList setValueWithDictionary:arrayData[i]];
        [mArray addObject:addressList];
    }
    return mArray;
}


@end
