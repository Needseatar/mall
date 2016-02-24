//
//  changeAddressModel.h
//  mall
//
//  Created by Mihua on 24/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface changeAddressModel : NSObject

@property (assign, nonatomic) NSInteger allow_offpay;
@property (retain, nonatomic) NSDictionary *allow_offpay_batch;
@property (retain, nonatomic) NSDictionary *content;
@property (retain, nonatomic) NSString *offpay_hash;
@property (retain, nonatomic) NSString *offpay_hash_batch;
@property (retain, nonatomic) NSString *state;

+(changeAddressModel *)setValueWithDictionary:(NSDictionary *)data;

@end
