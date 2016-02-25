//
//  submitOrderFootTableViewCell.h
//  mall
//
//  Created by Mihua on 23/2/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface submitOrderFootTableViewCell : UITableViewCell

-(void)setStrigLabel:(dataOrderListModel *)data cellOrderID:(void(^)(NSString *cellOrderID))action;

@end
