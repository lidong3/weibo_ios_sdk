//
//  UISystemCommon.m
//  UICommonLib
//
//  Created by 曹 立冬 on 13-6-3.
//  Copyright (c) 2013年 zhang yinglong. All rights reserved.
//


#import "UISystemCommon.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation UISystemCommon

+(NSMutableString *)filteNumber:(NSString *) number{
    
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:number.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:number];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
        }
        // --------- Add the following to get out of endless loop
        else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
        // --------- End of addition
    }
    
    return strippedString;
}

+ (void)callPhoneByStr:(NSString *)phoneNum
{
    if(phoneNum.length <= 0){
        
    }else{
        UIWebView *callPhoneWebVw = [[UIWebView alloc] init];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]]];
        [callPhoneWebVw loadRequest:request];
        [callPhoneWebVw release];
    }
}

+ (void)callPhoneByLongLong:(long long)phoneNum
{
    if(phoneNum <= 0){
        
    }else{
        UIWebView *callPhoneWebVw = [[UIWebView alloc] init];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%lld",phoneNum]]];
        [callPhoneWebVw loadRequest:request];
        [callPhoneWebVw release];
    }
}

//发短信
+ (void)sendSMS:(NSString *)number
           name:(NSString *)name
       newprice:(NSString *)newprice
     controller:(UIViewController *)controller
{
    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
	if (canSendSMS) {
		MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
		picker.messageComposeDelegate = (id <MFMessageComposeViewControllerDelegate>) controller;
		picker.navigationBar.tintColor = [UIColor blueColor];
        NSString *bodyStr = [NSString stringWithFormat:@"%@%@",name,newprice];
		picker.body = bodyStr;
        picker.navigationItem.title = @"短信";
		picker.recipients = [NSArray arrayWithObject:[NSString stringWithString:number]];
        PresentController(controller,picker, YES);
        [picker release];
	}
}

+(void)sendEmail:(NSArray *)mailAddress
         subject:(NSString *)subject
              cc:(NSArray *)cc
             bcc:(NSArray *)bcc
            body:(NSString *)body
  attachmentData:(NSData *)data
        mimeType:(NSString *)mimeType
        fileName:(NSString *)fileName
      controller:(UIViewController *)controller
{
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = (id <MFMailComposeViewControllerDelegate>)controller;
    if (subject) {
        [mc setSubject:subject];
    }
    if (mailAddress) {
        [mc setToRecipients:mailAddress];
    }
    if (cc) {
        [mc setCcRecipients:cc];
    }
    if (bcc) {
        [mc setBccRecipients:bcc];
    }
    if (body) {
        [mc setMessageBody:body isHTML:NO];
    }
    
    //    [mc setMessageBody:@"<HTML><B>Hello, Joe!</B><BR/>What do you know?</HTML>"
    //                 isHTML:YES];
    if (data && fileName && mimeType) {
        [mc addAttachmentData:data mimeType:mimeType fileName:fileName];
    }
    PresentController(controller,mc, YES);
}

//从相册选择图片
+ (void)LocalPhotoWithCallbackController:(UIViewController *)controller{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id<UIImagePickerControllerDelegate,UINavigationControllerDelegate>)controller;
    picker.allowsEditing = YES;
    PresentController(controller, picker, YES);
    [picker release];
}

//拍照
+ (void)takePhotoWithCallbackController:(UIViewController *)controller{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id<UIImagePickerControllerDelegate,UINavigationControllerDelegate>) controller;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        PresentController(controller, picker, YES);
        [picker release];
    }
}

//从相册选择视频
+ (void)LocalVideoWithCallbackController:(UIViewController *)controller{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为视频库
    NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
    NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType1,nil];
    [picker setMediaTypes:arrMediaTypes];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = (id<UIImagePickerControllerDelegate,UINavigationControllerDelegate>) controller;
    //设置选择后的图片可被编辑
    picker.allowsEditing = NO;
    PresentController(controller, picker, YES);
    [picker release];
}

+ (void)takeVideoWithCallbackController:(UIViewController *)controller
{
    UIImagePickerController* pickerView = [[UIImagePickerController alloc] init];
    pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
    NSArray* availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    pickerView.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];
    pickerView.videoMaximumDuration = 30;
    pickerView.delegate = (id<UIImagePickerControllerDelegate,UINavigationControllerDelegate>) controller;
    PresentController(controller, pickerView, YES);
    [pickerView release];
}

@end
