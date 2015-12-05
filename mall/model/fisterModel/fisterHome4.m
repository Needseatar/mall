//
//  fisterHome4.m
//  mall
//
//  Created by Mihua on 5/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterHome4.h"

@implementation fisterHome4


-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.rectangle1_data = dic[@"rectangle1_data"];
    self.rectangle1_image = dic[@"rectangle1_image"];
    self.rectangle1_type = dic[@"rectangle1_type"];
    self.type = dic[@"type"];
    self.type = dic[@"type"];
    self.type = dic[@"type"];
    self.type = dic[@"type"];
    self.type = dic[@"type"];
    self.type = dic[@"type"];
}

+(fisterHome4 *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary * dicData = data[@"home1"];
    fisterHome4 *mode = [[fisterHome4 alloc] init];
    [mode setValueWithDictionary:dicData];
    return mode;
}


@end
