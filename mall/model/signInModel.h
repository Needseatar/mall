//
//  signInModel.h
//  mall
//
//  Created by Mihua on 26/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface signInModel : NSObject

@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *error;

+(signInModel *)setUserToken:(NSDictionary *)dic;
@end
