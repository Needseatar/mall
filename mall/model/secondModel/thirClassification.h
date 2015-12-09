//
//  thirClassification.h
//  mall
//
//  Created by Mihua on 7/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface thirClassification : NSObject

@property (strong, nonatomic) NSString  *gc_name;
@property (assign, nonatomic) NSInteger gc_parent_id;  //请求下一级商品id


-(void)setValueWithDictionary:(NSDictionary *)dic;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data; //数据每三个thirClassification为一个array，组成一个大的NSMutableArray返回

@end
