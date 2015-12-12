//
//  commodityList.h
//  mall
//
//  Created by Mihua on 10/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commodityList : NSObject

@property (assign, nonatomic) NSString *evaluation_count;
@property (retain, nonatomic) NSString  *evaluation_good_star;
@property (retain, nonatomic) NSString  *goods_id;
@property (retain, nonatomic) NSString  *goods_image;
@property (retain, nonatomic) NSString  *goods_image_url;
@property (retain, nonatomic) NSString  *goods_marketprice;
@property (retain, nonatomic) NSString  *goods_name;
@property (retain, nonatomic) NSString  *goods_price;
@property (retain, nonatomic) NSString  *goods_salenum;
@property (retain, nonatomic) NSString *group_flag;
@property (retain, nonatomic) NSString *have_gift;
@property (retain, nonatomic) NSString *is_fcode;
@property (retain, nonatomic) NSString *is_presell;
@property (retain, nonatomic) NSString *is_virtual;
@property (retain, nonatomic) NSString *xianshi_flag;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;

@end
