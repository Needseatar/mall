//
//  fisterHome4.h
//  mall
//
//  Created by Mihua on 5/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fisterHome4 : NSObject

@property (retain, nonatomic) NSString    *rectangle1_data;
@property (retain, nonatomic) NSString    *rectangle1_image;
@property (retain, nonatomic) NSString    *rectangle1_type;
@property (retain, nonatomic) NSString    *rectangle2_data;
@property (retain, nonatomic) NSString    *rectangle2_image;
@property (retain, nonatomic) NSString    *rectangle2_type;
@property (retain, nonatomic) NSString    *square_data;
@property (retain, nonatomic) NSString    *square_image;
@property (retain, nonatomic) NSString    *square_type;
@property (retain, nonatomic) NSString    *title;

+(fisterHome1 *)setValueWithDictionary:(NSDictionary *)data;

@end
