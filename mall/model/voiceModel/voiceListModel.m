//
//  voiceListModel.m
//  mall
//
//  Created by Mihua on 2/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import "voiceListModel.h"

@implementation voiceListModel

-(void)setValueWithDictionary:(NSDictionary *)dic{
    
    
    self.inv_content = dic[@"inv_content"];
    if (![self.inv_content isKindOfClass:[NSString class]]) {
        self.inv_content=@"";
    }
    
    self.inv_id = dic[@"inv_id"];
    self.inv_title = dic[@"inv_title"];
    if (![self.inv_title isKindOfClass:[NSString class]]) {
        self.inv_title=@"";
    }
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSDictionary *dic = data[@"datas"];
    NSArray * arrayData = dic[@"invoice_list"];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayData.count; i++) {
        voiceListModel *voiceList = [[voiceListModel alloc] init];
        [voiceList setValueWithDictionary:arrayData[i]];
        [mArray addObject:voiceList];
    }
    return mArray;
}


@end
