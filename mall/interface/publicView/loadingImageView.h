//
//  loadingImageView.h
//  mall
//
//  Created by Mihua on 29/12/15.
//  Copyright © 2015年 Mihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loadingImageView : NSObject

//创建加载视图
+(UIView *)setLoadingImageView:(CGRect )fr;

+(UIView *)setNetWorkError:(CGRect )fr;

+(UILabel *)setNetWorkRefreshError:(CGRect )fr viewString:(NSString *)string;

@end
