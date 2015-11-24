//
//  fiveViewUserTableViewCell.h
//  mall
//
//  Created by Mihua on 20/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fiveBlockString.h"

@interface fiveViewUserTableViewCell : UITableViewCell

-(void)comeBackActionString:(void(^)(NSString *string))action; //传回动作的名字

@end
