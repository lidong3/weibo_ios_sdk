//
//  MyLoadingView.h
//  tanzhi
//
//  Created by Chen Lei on 11-7-22.
//  Copyright 2011年 ä¸­è½¯æ³°å. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MyLoadingView : UIView {
    UIControl *_mask;
    UILabel *loadingLabel;
    UIActivityIndicatorView *activityView1;
    UIImageView *failedImageView;
    UIImageView *successImageView;
}

@property(nonatomic,assign,getter = getLoadingText,setter = setLoadingText:) NSString *text;

-(id)initWithTitle:(NSString *)loadingTitle;
-(void)setmaskAlpha:(CGFloat)malpha;
-(void)setHideActivityIndicatorViewOrNot:(BOOL)isHide isSuccess:(BOOL)success;
- (void)showInView:(UIView *)view;
- (void)showInView:(UIView *)view forceWait:(BOOL)wait;
- (void) dismissLoadingView;
- (void) dismissLoadingViewAnimated:(BOOL)animated; 

@end
