//
//  ShoppingInvInfo.m
//  mall
//
//  Created by Mihua on 14/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "ShoppingInvInfo.h"

@implementation ShoppingInvInfo

-(void)setValueWithDictionary:(NSDictionary *)dic
{
    self.content = dic[@"content"];
    self.inv_code = dic[@"inv_code"];
    self.inv_company = dic[@"inv_company"];
    self.inv_content = dic[@"inv_content"];
    self.inv_goto_addr = dic[@"inv_goto_addr"];
    self.inv_id = dic[@"inv_id"];
    self.inv_rec_mobphone = dic[@"inv_rec_mobphone"];
    self.inv_rec_name = dic[@"inv_rec_name"];
    self.inv_rec_province = dic[@"inv_rec_province"];
    self.inv_reg_addr = dic[@"inv_reg_addr"];
    self.inv_reg_baccount = dic[@"inv_reg_baccount"];
    self.inv_reg_bname = dic[@"inv_reg_bname"];
    self.inv_reg_phone = dic[@"inv_reg_phone"];
    self.inv_state = dic[@"inv_state"];
    self.inv_title = dic[@"inv_title"];
    self.member_id = dic[@"member_id"];
}
+(ShoppingInvInfo *)setValueWithDictionary:(NSDictionary *)data
{
    NSDictionary *dicData = data[@"inv_info"];
    ShoppingInvInfo *invInfo = [[ShoppingInvInfo alloc] init];
    [invInfo setValueWithDictionary:dicData];
    return invInfo;
}


@end
