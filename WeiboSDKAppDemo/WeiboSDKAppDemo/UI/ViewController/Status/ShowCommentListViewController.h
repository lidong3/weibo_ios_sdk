//
//  ShowCommentListViewController.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-5.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UIBaseViewController.h"
#import "PortraitManager.h"
#import "CommentManager.h"
#import "CommentCell.h"

@interface ShowCommentListViewController : UIBaseViewController
<PortraitManagerDelegate,
CommentManagerDelegate,
CommentCellDelegate>
{
    NSMutableArray *_commentArray;
    BOOL isScrolling;
    BOOL isFirstRequest;
    UIImageView *_bigImageView;
}
@property (nonatomic, assign)long long statusId;

@end
