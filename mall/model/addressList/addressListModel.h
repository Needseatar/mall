//
//  addressListModel.h
//  mall
//
//  Created by Mihua on 26/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addressListModel : NSObject

@property (retain, nonatomic) NSString *address;
@property (retain, nonatomic) NSString *address_id;
@property (retain, nonatomic) NSString *area_id;
@property (retain, nonatomic) NSString *area_info;
@property (retain, nonatomic) NSString *city_id;
@property (retain, nonatomic) NSString *dlyp_id;
@property (retain, nonatomic) NSString *is_default;
@property (retain, nonatomic) NSString *member_id;
@property (retain, nonatomic) NSString *mob_phone;
@property (retain, nonatomic) NSString *tel_phone;
@property (retain, nonatomic) NSString *true_name;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;


@end
