//
//  merchantModel.h
//  mall
//
//  Created by Mihua on 6/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface merchantModel : NSObject

@property (retain, nonatomic) NSString *store_address;
@property (retain, nonatomic) NSString *store_area_info;
@property (retain, nonatomic) NSString *store_id;
@property (retain, nonatomic) NSString *store_name;


-(void)setValueWithDictionary:(NSDictionary *)dic;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;

@end
