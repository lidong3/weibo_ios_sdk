//
//  UIBaseViewController.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-11-29.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLoadingView.h"
#import "SRRefreshView.h"
#import "UIDeviceCommon.h"
#import "CustomNavigationBar.h"

@interface UIBaseViewController : UIViewController
<UITableViewDataSource,
UITableViewDelegate,
SRRefreshDelegate,
UITextViewDelegate>
{
    BOOL _IsTableViewEdit;
    SRRefreshView   *_slimeView;
}

@property (nonatomic, strong) UITableView *baseTableView;
@property (nonatomic, retain) MyLoadingView *loadingView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) BOOL isSupportRefreshView;
@property (nonatomic, assign) BOOL tableViewIsGroupStyle;
@property (nonatomic, strong) CustomNavigationBar *navigationBarView;

- (void)initViews;

- (void)leftBarButtomItemWithNormalName:(NSString*)normalName
                               highName:(NSString *)highName
                               selector:(SEL)selector
                                 target:(id)target;

- (void)rightBarButtomItemWithNormalName:(NSString*)normalName
                                highName:(NSString *)highName
                                selector:(SEL)selector
                                  target:(id)target;

- (void)requestInterface;
- (void)back;

@end
