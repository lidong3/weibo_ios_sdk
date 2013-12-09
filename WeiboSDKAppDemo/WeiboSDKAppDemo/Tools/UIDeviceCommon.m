//
//  UIDeviceCommon.m
//  Main
//
//  Created by qxxw_a_n on 13-8-16.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UIDeviceCommon.h"
#import <sys/sysctl.h>
#import <UIKit/UIKit.h>

@implementation UIDeviceCommon

+ (BOOL)isIPhone5
{
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO;
}

+ (BOOL)isIPhone4
{
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO;
}

+ (BOOL)isIPhone3
{
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO;
}

+ (BOOL)isIOS7
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
}

@end
