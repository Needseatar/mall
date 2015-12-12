//
//  signInModel.h
//  mall
//
//  Created by Mihua on 26/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface signInModel : NSObject

@property (assign, nonatomic) NSInteger      code;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *error;
@property (assign, nonatomic) BOOL     whetherSignIn;


+(signInModel *)sharedUserTokenInModel:(signInModel *)signInModelKey;  //单例创建，如果signInModelKey的code是200，那么里面的值将被覆盖，没有赋值的，数据将清零， whetherSignIn将变No, 如果有令牌，whetherSignIn将赋予yes,code是0时，所有数据清零，whetherSignIn为No

+(signInModel *)setUserToken:(NSDictionary *)dic; //常规创建

+(signInModel *)initSingleCase;   //单例创建，code赋予了20， 创建之后使用+(signInModel *)sharedUserTokenInModel:(signInModel *)signInModelKey函数将是保留最后一次signInModelKey赋予的值

+(signInModel *)initSetUser; //初始化，使whetherSignIn置零
@end
