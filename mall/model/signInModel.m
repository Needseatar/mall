//
//  signInModel.m
//  mall
//
//  Created by Mihua on 26/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "signInModel.h"

@implementation signInModel

+(signInModel *)sharedUserTokenInModel:(signInModel *)signInModelKey
{
    //是线程安全的, 多个线程调用没有问题
    //推荐使用这种形式创建单例
    static signInModel *SIModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SIModel.whetherSignIn = NO;
        SIModel = [[signInModel alloc] init];
    });
    if (signInModelKey.code == 20) {//单例返回
        return SIModel;
    }
    if (signInModelKey.code == 200) {
        
        //数据清零
        SIModel.code = 0;
        SIModel.error = [[NSString alloc] init];;
        SIModel.key = [[NSString alloc] init];;
        SIModel.username = [[NSString alloc] init];
        SIModel.whetherSignIn = NO;
        
        //开始赋值
        SIModel.code = signInModelKey.code;
        SIModel.error = signInModelKey.error;
        SIModel.key = signInModelKey.key;
        SIModel.username = signInModelKey.username;
        if (SIModel.key != nil) {
            SIModel.whetherSignIn = YES;
        }
    }else if(signInModelKey.code == 0)
    {
        //数据清零
        SIModel.code = 0;
        SIModel.error = [[NSString alloc] init];;
        SIModel.key = [[NSString alloc] init];;
        SIModel.username = [[NSString alloc] init];
        SIModel.whetherSignIn = NO;
    }
    return SIModel;
}

+(signInModel *)setUserToken:(NSDictionary *)dic
{
    signInModel * SIModel = [[signInModel alloc] init];
    NSDictionary *datas = [[NSDictionary alloc] init];
    SIModel.code = [dic[@"code"] integerValue];
    datas = dic[@"datas"];
    //秘密或账号错误
    SIModel.error = datas[@"error"];
    SIModel.key = datas[@"key"];
    SIModel.username = datas[@"username"];
    return SIModel;
}

+(signInModel *)initSetUser
{
    signInModel * SIModel = [[signInModel alloc] init];
    SIModel.whetherSignIn = NO;
    SIModel.code = 0;
    return SIModel;
}

+(signInModel *)initSingleCase
{
    signInModel * SIModel = [[signInModel alloc] init];
    SIModel.whetherSignIn = NO;
    SIModel.code = 20;
    return SIModel;

}

@end
