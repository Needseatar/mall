//
//  ShoppingInvInfo.h
//  mall
//
//  Created by Mihua on 14/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingInvInfo : NSObject

@property (retain, nonatomic) NSString *content;
@property (retain, nonatomic) NSString *inv_code;
@property (retain, nonatomic) NSString *inv_company;
@property (retain, nonatomic) NSString *inv_content;
@property (retain, nonatomic) NSString *inv_goto_addr;
@property (retain, nonatomic) NSString *inv_id;
@property (retain, nonatomic) NSString *inv_rec_mobphone;
@property (retain, nonatomic) NSString *inv_rec_name;
@property (retain, nonatomic) NSString *inv_rec_province;
@property (retain, nonatomic) NSString *inv_reg_addr;
@property (retain, nonatomic) NSString *inv_reg_baccount;
@property (retain, nonatomic) NSString *inv_reg_bname;
@property (retain, nonatomic) NSString *inv_reg_phone;
@property (retain, nonatomic) NSString *inv_state;
@property (retain, nonatomic) NSString *inv_title;
@property (retain, nonatomic) NSString *member_id;

-(void)setValueWithDictionary:(NSDictionary *)dic;
+(ShoppingInvInfo *)setValueWithDictionary:(NSDictionary *)data;

@end
