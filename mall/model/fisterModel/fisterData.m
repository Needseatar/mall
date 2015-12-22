//
//  fisterData.m
//  mall
//
//  Created by Mihua on 5/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import "fisterData.h"

@implementation fisterData

-(void)setValueWithFlistDictionary:(NSDictionary *)dic{
    self.FList = [fisterList setValueWithDictionary:dic];
}

+(fisterData *)setValueWithDictionary:(NSDictionary *)data{
    fisterData *mode = [[fisterData alloc] init];
    mode.FHome = [[NSMutableArray alloc] init];
    NSArray * arrayData = data[@"datas"];
    
    for (int i=0; i<arrayData.count; i++) {
        
        NSDictionary *dicHome = arrayData[i];
        for (NSDictionary *dic in dicHome) { //根据里面的字典选择相应的model
            NSString *stringkey = [NSString stringWithFormat:@"%@", dic];
            NSLog(@"%@", stringkey);
            if ([stringkey isEqualToString:@"home1"]) { //home1
                NSDictionary *dicHome1 = arrayData[i];
                [mode.FHome addObject:[fisterHome1 setValueWithDictionary:dicHome1]];
            }else if ([stringkey isEqualToString:@"home4"]) //home4
            {
                NSDictionary *dicHome4 = arrayData[i];
                [mode.FHome addObject:[fisterHome4 setValueWithDictionary:dicHome4]];
            }else if ([stringkey isEqualToString:@"goods"]) //goods
            {
                NSDictionary *dicgoods = arrayData[i];
                [mode setValueWithFlistDictionary:dicgoods[@"goods"]];
            }
        }
    }
    return mode;
}
@end
