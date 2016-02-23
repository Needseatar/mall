//
//  orderGroupList.m
//  mall
//
//  Created by Mihua on 16/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//


#import "orderGroupList.h"

@implementation orderGroupList

-(void)setValueWithDictionary:(NSDictionary *)dic{
    self.add_time = dic[@"add_time"];
    self.pay_amount = dic[@"pay_amount"];
    self.pay_sn = dic[@"pay_sn"];
    
    NSMutableArray *mArray = [dataOrderListModel setValueWithDictionary:dic];
    self.packArray = mArray[mArray.count-1];
    [mArray removeObjectAtIndex:(mArray.count-1)];
    self.order_list = mArray;
}

+(NSMutableArray *)setValueWithDictionary:(NSDictionary *)data{
    NSArray * arrayData = data[@"order_group_list"];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayData.count; i++) {
        orderGroupList *voiceList = [[orderGroupList alloc] init];
        [voiceList setValueWithDictionary:arrayData[i]];
        [mArray addObject:voiceList];
    }
    return mArray;
}

- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count); //获取本类所有的class
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];//创建一个数组，指定容量为size
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]); //获取本类的所有属性的名字
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];

        NSLog(@"%@", [NSString stringWithUTF8String: propertyName]);
    }
    free(properties); //free（）是C标准库里面的，是一个函数。它调用malloc（），可以立即释放内存
    return propertiesArray;
}

@end
