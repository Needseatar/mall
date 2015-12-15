//
//  secondCommendList.h
//  mall
//
//  Created by Mihua on 14/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface secondCommendList : NSObject

@property(retain, nonatomic) NSString * goods_id;
@property(retain, nonatomic) NSString * goods_image_url;
@property(retain, nonatomic) NSString * goods_name;
@property(retain, nonatomic) NSString * goods_price;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;

@end
