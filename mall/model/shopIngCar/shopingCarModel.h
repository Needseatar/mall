//
//  shopingCarModel.h
//  mall
//
//  Created by Mihua on 6/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shopingCarModel : NSObject

@property (retain, nonatomic) NSString  *bl_id;
@property (retain, nonatomic) NSString  *buyer_id;
@property (retain, nonatomic) NSString  *cart_id;
@property (assign, nonatomic) NSInteger goods_id;
@property (retain, nonatomic) NSString  *goods_image;
@property (retain, nonatomic) NSString  *goods_image_url;
@property (retain, nonatomic) NSString  *goods_name;
@property (retain, nonatomic) NSString  *goods_num;
@property (retain, nonatomic) NSString  *goods_price;
@property (retain, nonatomic) NSString  *goods_sum;
@property (retain, nonatomic) NSString  *store_id;
@property (retain, nonatomic) NSString  *store_name;


-(void)setValueWithDictionary:(NSDictionary *)dic;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;

@end
