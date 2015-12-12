//
//  oneClassification.h
//  mall
//
//  Created by Mihua on 30/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface oneClassification : NSObject

@property (strong, nonatomic) NSString       *gc_name;
@property (assign, nonatomic) NSInteger      gc_parent_id;  //请求下一级商品id


-(void)setValueWithDictionary:(NSDictionary *)dic;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;

@end
