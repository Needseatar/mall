//
//  secondListViewController.h
//  mall
//
//  Created by Mihua on 9/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commodityList.h"
#import "secondListTableViewCell.h"
#import "goodInformationViewController.h"
#import "MJRefresh.h"

@interface secondListViewController : UIViewController

/*
* gc_id 分类编号
* keyword 搜索关键字
* brand 品牌
* gc_id和keyword和brand三选一不能同时出
*
*/

@property (retain, nonatomic) NSString  *parameter; //请求的参数

@end
