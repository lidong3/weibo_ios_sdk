//
//  ShowViewWindow.h
//  UICommonLib
//
//  Created by 曹 立冬 on 13-5-15.
//  Copyright (c) 2013年 zhang yinglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowViewWindow : NSObject

+ (void)showViewInWindow:(UIView *)view
                   alpha:(float)alpha
                 hasMask:(BOOL)hasMask
               animation:(BOOL)animation;

+ (void)supportTapToDismiss;

+ (BOOL)viewIsInWindow;

+ (void)dismissViewInWindowWithAnimation:(BOOL)animation;

@end
