//
//  addressAreaModel.h
//  mall
//
//  Created by Mihua on 27/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addressAreaModel : NSObject

@property (retain, nonatomic) NSString *area_id;
@property (retain, nonatomic) NSString *area_name;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;


@end
