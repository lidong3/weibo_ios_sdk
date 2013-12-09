//
//  SendStatusViewController.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-3.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UIBaseViewController.h"
#import "StatusManager.h"

@interface SendStatusViewController : UIBaseViewController
<UITextViewDelegate,
StatusManagerDelegate,
UIActionSheetDelegate>
{
    UITextView *_statusTextView;
    UILabel *_alertCountLabel;
    UIButton *_pickImageBtn;
    NSData *_imageData;
}
@end
