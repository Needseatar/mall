//
//  fisterHome1.m
//  mall
//
//  Created by Mihua on 5/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterHome1.h"

@implementation fisterHome1


-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.data = dic[@"data"];
    self.image = dic[@"image"];
    self.title = dic[@"title"];
    self.type = dic[@"type"];
}

+(fisterHome1 *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary * dicData = data[@"home1"];
    fisterHome1 *mode = [[fisterHome1 alloc] init];
    [mode setValueWithDictionary:dicData];
    return mode;
}

@end
