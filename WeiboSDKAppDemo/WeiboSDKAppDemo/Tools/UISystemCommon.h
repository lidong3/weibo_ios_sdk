//
//  UISystemCommon.h
//  UICommonLib
//
//  Created by 曹 立冬 on 13-6-3.
//  Copyright (c) 2013年 zhang yinglong. All rights reserved.
//

#import <MessageUI/MessageUI.h>

#define SystemVerson [[[UIDevice currentDevice] systemVersion] floatValue]
#define PresentController(__Target__,__Controller__,__Animation__) if (SystemVerson>=6.0) {\
[__Target__ presentViewController:__Controller__ animated:__Animation__ completion:^{\
\
}];\
}else{\
[__Target__ presentModalViewController:__Controller__ animated:__Animation__];\
}

#define DismissPresentController(__Target__,__Controller__,__Animation__) if (SystemVerson>=6.0) {\
[__Target__ dismissViewControllerAnimated:__Animation__ completion:^{\
\
}];\
}else{\
[__Target__ dismissModalViewControllerAnimated:__Animation__];\
}

@interface UISystemCommon : NSObject


//打电话
+ (void)callPhoneByStr:(NSString *)phoneNum;

+ (void)callPhoneByLongLong:(long long)phoneNum;

//发短信
+ (void)sendSMS:(NSString *)number
           name:(NSString *)name
       newprice:(NSString *)newprice
     controller:(UIViewController *)controller;

//发邮件
+(void)sendEmail:(NSArray *)mailAddress
         subject:(NSString *)subject
              cc:(NSArray *)cc
             bcc:(NSArray *)bcc
            body:(NSString *)body
  attachmentData:(NSData *)data
        mimeType:(NSString *)mimeType
        fileName:(NSString *)fileName
      controller:(UIViewController *)controller;

//相册
+ (void)LocalPhotoWithCallbackController:(UIViewController *)controller;

//拍照
+ (void)takePhotoWithCallbackController:(UIViewController *)controller;

//选取视频
+ (void)LocalVideoWithCallbackController:(UIViewController *)controller;

//选择录像
+ (void)takeVideoWithCallbackController:(UIViewController *)controller;

@end
