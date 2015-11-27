//
//  fiveMyMallmodel.m
//  mall
//
//  Created by Mihua on 27/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fiveMyMallmodel.h"

@implementation fiveMyMallmodel


+(fiveMyMallmodel *)setUserMall:(NSDictionary *)dic
{
    fiveMyMallmodel * myMall = [[fiveMyMallmodel alloc] init];
    NSDictionary *datas = [[NSDictionary alloc] init];
    datas = dic[@"datas"];
    NSDictionary *member_info = [[NSDictionary alloc] init];
    member_info = datas[@"member_info"];
    //秘密或账号错误
    myMall.available_rc_balance = member_info[@"available_rc_balance"];
    myMall.avator = member_info[@"avator"];
    myMall.point = member_info[@"point"];
    myMall.predepoit = member_info[@"predepoit"];
    myMall.user_name = member_info[@"user_name"];
    return myMall;
}


@end
