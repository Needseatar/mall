//
//  oneClassification.h
//  mall
//
//  Created by Mihua on 30/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface oneClassification : NSObject

@property (strong, nonatomic) NSString *gc_name;
@property (assign, nonatomic) int      gc_parent_id;

@property (assign, nonatomic) id       downID; //保存了下一级的id地址


-(void)setValueWithDictionary:(NSDictionary *)dic;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;

@end
