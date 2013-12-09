//
//  StatusPublicTimeLineListViewController.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-11-29.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UIBaseViewController.h"
#import "StatusManager.h"
#import "StatusCell.h"
#import "PortraitManager.h"
#import "CommentPopView.h"

@interface StatusPublicTimeLineListViewController : UIBaseViewController
<StatusManagerDelegate,
StatusCellDelegate,
PortraitManagerDelegate,
CommentPopViewDelegate,
UIActionSheetDelegate>
{
    NSMutableArray *_statusArray;
    BOOL isScrolling;
    BOOL isFirstRequest;
    UIImageView *_bigImageView;
    CommentPopView *_commentPopView;
    WeiboStatus *_curCommentStatus;
    int commentType;
}

@end
