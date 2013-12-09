//
//  StatusUserTimeLineListViewController.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-3.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UIBaseViewController.h"
#import "StatusManager.h"
#import "StatusCell.h"
#import "PortraitManager.h"
#import "WeiboUser.h"

@interface StatusUserTimeLineListViewController : UIBaseViewController
<StatusManagerDelegate,
StatusCellDelegate,
PortraitManagerDelegate>
{
    NSMutableArray *_statusArray;
    BOOL isScrolling;
    BOOL isFirstRequest;
    UIImageView *_bigImageView;
}

@property (nonatomic, assign)WeiboUser *user;

@end
