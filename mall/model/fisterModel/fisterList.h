//
//  fisterList.h
//  mall
//
//  Created by Mihua on 5/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fisterList : NSObject

@property (retain, nonatomic) NSString    *goods_id;
@property (retain, nonatomic) NSString    *goods_image;
@property (retain, nonatomic) NSString    *goods_name;
@property (retain, nonatomic) NSString    *goods_price;
@property (retain, nonatomic) NSString    *goods_promotion_price;

+(NSArray *)setValueWithDictionary:(NSDictionary *)data;

@end
