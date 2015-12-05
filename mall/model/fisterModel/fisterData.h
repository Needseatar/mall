//
//  fisterData.h
//  mall
//
//  Created by Mihua on 5/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "fisterHome1.h"
#import "fisterHome4.h"
#import "fisterList.h"

@interface fisterData : NSObject

@property (retain, nonatomic) NSMutableArray *FHome;
@property (retain, nonatomic) fisterList    *FList;

-(void)setValueWithDictionary:(NSDictionary *)dic;

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;

@end
