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
//创建加载失败后的视图
+(UIView *)setNetWorkError:(CGRect )fr;
//创建提示字符
+(UILabel *)setNetWorkRefreshError:(CGRect )fr viewString:(NSString *)string;
//创建当前分类或者搜索暂时没有商品视图
+(UIView *)setClassification:(CGRect )fr;

@end
