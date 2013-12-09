//
//  UIDeviceCommon.h
//  Main
//
//  Created by qxxw_a_n on 13-8-16.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kNavigationBarHeight            ([UIDeviceCommon isIOS7]?64:44)
#define kStatusBarHeight                ([UIDeviceCommon isIOS7]?0:20)
#define SCREEWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEHEIGHT [UIScreen mainScreen].bounds.size.height

@interface UIDeviceCommon : NSObject
+ (BOOL)isIPhone5;
+ (BOOL)isIPhone4;
+ (BOOL)isIPhone3;
+ (BOOL)isIOS7;
@end
