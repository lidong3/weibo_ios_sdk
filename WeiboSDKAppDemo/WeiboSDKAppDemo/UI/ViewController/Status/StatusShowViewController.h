//
//  StatusShowViewController.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-5.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UIBaseViewController.h"
#import "WeiboStatus.h"
#import "CommentPopView.h"
#import "CommentManager.h"

@interface StatusShowViewController : UIBaseViewController
<UIActionSheetDelegate,
CommentPopViewDelegate,
CommentManagerDelegate,
UIAlertViewDelegate>
{
    CommentPopView *_commentPopView;
}
@property (nonatomic, strong)WeiboStatus *status;

@end
