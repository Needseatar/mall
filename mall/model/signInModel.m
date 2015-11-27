//
//  signInModel.m
//  mall
//
//  Created by Mihua on 26/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "signInModel.h"

@implementation signInModel

+(signInModel *)setUserToken:(NSDictionary *)dic
{
    signInModel * SIModel = [[signInModel alloc] init];
    NSDictionary *datas = [[NSDictionary alloc] init];
    SIModel.code = dic[@"code"];
    datas = dic[@"datas"];
    //秘密或账号错误
    SIModel.error = datas[@"error"];
    SIModel.key = datas[@"key"];
    SIModel.username = datas[@"username"];
    NSLog(@"%@, %@, %@, %@",SIModel.error ,SIModel.code, SIModel.key, SIModel.username);
    return SIModel;
}

@end
