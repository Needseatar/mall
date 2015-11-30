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
@property (strong, nonatomic) NSNumber *gc_parent_id;


-(void)setValueWithDictionary:(NSDictionary *)dic;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;

@end
