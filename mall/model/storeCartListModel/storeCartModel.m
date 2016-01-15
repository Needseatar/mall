//
//  storeCartModel.m
//  mall
//
//  Created by Mihua on 14/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "storeCartModel.h"

@implementation storeCartModel


-(void)setValueWithDictionary:(NSDictionary *)dic{
    
    self.available_predeposit = dic[@"available_predeposit"];
    self.available_rc_balance = dic[@"available_rc_balance"];
    self.freight_hash = dic[@"freight_hash"];
    self.ifshow_offpay = dic[@"ifshow_offpay"];
    self.vat_hash = dic[@"vat_hash"];
    
    
    self.inv_info = [ShoppingInvInfo setValueWithDictionary:dic];
    self.address_info = [addressInfo setValueWithDictionary:dic];
    self.store_cart_list = [storeCartInformaton setValueWithDictionary:dic];
}

+(storeCartModel *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary *dicData = data[@"datas"];
    storeCartModel * storeModel = [[storeCartModel alloc] init];
    [storeModel setValueWithDictionary:dicData];
    return storeModel;
}


@end
