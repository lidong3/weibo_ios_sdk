//
//  WeiboHomePageViewController.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-3.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UIBaseViewController.h"
#import "StatusManager.h"
#import "StatusCell.h"
#import "PortraitManager.h"
#import "CommentPopView.h"

@interface WeiboHomePageViewController : UIBaseViewController
<StatusManagerDelegate,
StatusCellDelegate,
PortraitManagerDelegate,
UIActionSheetDelegate,
CommentPopViewDelegate>
{
    NSMutableArray *_statusArray;
    BOOL isScrolling;
    BOOL isFirstRequest;
    UIImageView *_bigImageView;
    //评论相关
    CommentPopView *_commentPopView;
    WeiboStatus *_curCommentStatus;
    int commentType;
}

@end
