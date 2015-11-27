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

@interface fiveViewUserTableViewCell : UITableViewCell

-(void)comeBackActionString:(void(^)(NSString *string))action; //传回动作的名字

-(void)setButtonAndUser:(BOOL)whetherSignIn signInUser:(signInModel *)signInUser; //传入是否登录参数和令牌

@end
