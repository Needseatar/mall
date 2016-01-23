//
//  PaymentMethodTableViewCell.h
//  mall
//
//  Created by Mihua on 20/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingInvInfo.h"
#import "storeCartModel.h"

@interface PaymentMethodTableViewCell : UITableViewCell

-(void)setPeopleInformation:(storeCartModel *)data payMethodString:(NSString *)payMethodString;


@end
