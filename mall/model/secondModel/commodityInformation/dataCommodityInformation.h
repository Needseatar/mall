//
//  dataCommodityInformation.h
//  mall
//
//  Created by Mihua on 14/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "secondCommendList.h"
#import "secondGoodsInfo.h"
#import "secondStoreList.h"

@interface dataCommodityInformation : NSObject

@property(retain, nonatomic) NSMutableArray  *goods_commend_list;
@property(retain, nonatomic) NSString        *goods_image;
@property(retain, nonatomic) secondGoodsInfo *goods_info;
@property(retain, nonatomic) NSString        *spec_image;
@property(retain, nonatomic) NSDictionary    *spec_list;
@property(retain, nonatomic) secondStoreList *store_info;

+(dataCommodityInformation *)setValueWithDictionary:(NSDictionary *)data;

@end
