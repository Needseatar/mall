//
//  secondStoreList.m
//  mall
//
//  Created by Mihua on 14/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "secondStoreList.h"

@implementation secondStoreList

-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.all = dic[@"all"];
    self.avatar  = dic[@"avatar"];
    self.good_percent = dic[@"good_percent"];
    self.member_id = dic[@"member_id"];
    self.member_name = dic[@"member_name"];
    self.store_credit = dic[@"store_credit"];
    self.store_id = dic[@"store_id"];
    self.store_name = dic[@"store_name"];
    self.store_phone = dic[@"store_phone"];
    self.store_qq = dic[@"store_qq"];
    self.store_ww = dic[@"store_ww"];

}

+(secondStoreList *)setValueWithDictionary:(NSDictionary *)data{
    secondStoreList *mode = [[secondStoreList alloc] init];
    [mode setValueWithDictionary:data[@"store_info"]];
    return mode;
}


@end
