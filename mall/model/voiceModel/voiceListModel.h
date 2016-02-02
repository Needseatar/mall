//
//  voiceListModel.h
//  mall
//
//  Created by Mihua on 2/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface voiceListModel : NSObject

@property (retain, nonatomic) NSString *inv_content;
@property (retain, nonatomic) NSString *inv_id;
@property (retain, nonatomic) NSString *inv_title;

-(void)setValueWithDictionary:(NSDictionary *)dic;
+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data;

@end
