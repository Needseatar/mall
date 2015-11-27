//
//  fiveViewUserTableViewCell.h
//  mall
//
//  Created by Mihua on 20/11/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fiveBlockString.h"
#import "signInModel.h"
#import "fiveMyMallmodel.h"
#import "UIImageView+AFNetworking.h"


@interface fiveViewUserTableViewCell : UITableViewCell

-(void)comeBackActionString:(void(^)(NSString *string))action; //传回动作的名字

-(void)setButtonAndUser:(signInModel *)signInUser
             userMyMall:(fiveMyMallmodel *)userMyMall; //传入数据

@end
