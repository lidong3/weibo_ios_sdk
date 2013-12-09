//
//  ShowViewWindow.m
//  UICommonLib
//
//  Created by Peter on 13-5-15.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "ShowViewWindow.h"

@implementation ShowViewWindow

static UIWindow *_currentWindow = nil;
static UIView *_currentView = nil;
static UIView *_mask = nil;
static UITapGestureRecognizer *_tap = nil;

+ (void)showViewInWindow:(UIView *)view
                   alpha:(float)alpha
                 hasMask:(BOOL)hasMask
               animation:(BOOL)animation
{
    //两个float不能直接等于  当透明度为<0.01时候蒙版遮挡不住了
    
    alpha = alpha < 0.01?0.02:alpha;
    _currentView = view;
    _currentView.alpha = 0.0;
    if (view)
    {
        _currentWindow = view.window ? view.window : [UIApplication sharedApplication].keyWindow;
        CGPoint point = CGPointMake(_currentWindow.frame.size.width/2, _currentWindow.frame.size.height/2);
        view.center = point;
        if (hasMask) {
            _mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            
            _mask.alpha = 0.0;
            _mask.backgroundColor = [UIColor blackColor];  // blackColor
            [_currentWindow addSubview:_mask];
        }
        [_currentWindow addSubview:_currentView];
        if (animation) {
            [UIView animateWithDuration:.5 animations:^{
                if (_mask) {
                    _mask.alpha = alpha;
                }
                _currentView.alpha = 1.0;
            } completion:^(BOOL finished) {
                
            }];
        }else{
            if (_mask) {
                _mask.alpha = alpha;
            }
            _currentView.alpha = 1.0;
        }
    }else{
        NSLog(@"showViewInWindow 当前view不存在");
    }
}

+ (void)supportTapToDismiss
{
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_currentWindow addGestureRecognizer:_tap];
}

+ (void)tap
{
    [self dismissViewInWindowWithAnimation:YES];
}

+ (BOOL)viewIsInWindow
{
    BOOL ret = NO;
    if (_currentView && _currentView.window == _currentWindow) {
        ret = YES;
    }
    return ret;
}

+ (void)dismissViewInWindowWithAnimation:(BOOL)animation
{
    if ([self viewIsInWindow]) {
        if (animation) {
            [UIView animateWithDuration:.5 animations:^{
                if (_mask) {
                    _mask.alpha = 0.0;
                }
                _currentView.alpha = 0.0;
            } completion:^(BOOL finished) {
                if (_mask) {
                    [_mask removeFromSuperview];
                    _mask = nil;
                }
                if (_tap) {
                    [_currentWindow removeGestureRecognizer:_tap];
                    _tap = nil;
                }
                [_currentView removeFromSuperview];
                _currentView = nil;
            }];
        }else{
            if (_mask) {
                [_mask removeFromSuperview];
                _mask = nil;
            }
            if (_tap) {
                [_currentWindow removeGestureRecognizer:_tap];
                _tap = nil;
            }
            [_currentView removeFromSuperview];
            _currentView = nil;
        }
    }
}

@end
