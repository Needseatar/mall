//
//  fisterHome1.h
//  mall
//
//  Created by Mihua on 5/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fisterHome1 : NSObject

@property (retain, nonatomic) NSString    *data;
@property (retain, nonatomic) NSString    *image;
@property (retain, nonatomic) NSString    *title;
@property (retain, nonatomic) NSString    *type;

+(fisterHome1 *)setValueWithDictionary:(NSDictionary *)data;
@end
