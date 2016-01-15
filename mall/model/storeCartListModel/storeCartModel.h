//
//  storeCartModel.h
//  mall
//
//  Created by Mihua on 14/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "addressInfo.h"
#import "ShoppingInvInfo.h"
#import "storeCartInformaton.h"

@interface storeCartModel : NSObject

@property (retain, nonatomic) addressInfo          *address_info;
@property (retain, nonatomic) NSString             *available_predeposit;
@property (retain, nonatomic) NSString             *available_rc_balance;
@property (retain, nonatomic) NSString             *freight_hash;
@property (retain, nonatomic) NSString             *ifshow_offpay;
@property (retain, nonatomic) ShoppingInvInfo      *inv_info;
@property (retain, nonatomic) NSArray              *store_cart_list;
@property (retain, nonatomic) NSString             *vat_hash;


-(void)setValueWithDictionary:(NSDictionary *)dic;
+(storeCartModel *)setValueWithDictionary:(NSDictionary *)data;

@end
