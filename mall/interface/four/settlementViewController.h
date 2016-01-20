//
//  settlementViewController.h
//  mall
//
//  Created by Mihua on 13/1/16.
//  Copyright © 2016年 Mihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "storeCartModel.h"
#import "addressInfo.h"
#import "ShoppingInvInfo.h"
#import "storeCartModel.h"
#import "settlementOrderTableViewCell.h"
#import "settlementShoppingTableViewCell.h"
#import "downSettlementTableViewCell.h"
#import "settlementAddressTableViewCell.h"
#import "PaymentMethodTableViewCell.h"

@interface settlementViewController : UIViewController

@property (retain, nonatomic) NSString *shoppingCarGoodsID;

@end
