//
//  myOrderModel.h
//  mall
//
//  Created by Mihua on 16/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myOrderModel : NSString

@property (retain, nonatomic) NSString *order_group_list;
@property (retain, nonatomic) NSNumber *hasmore;
@property (retain, nonatomic) NSNumber *page_total;

@end
