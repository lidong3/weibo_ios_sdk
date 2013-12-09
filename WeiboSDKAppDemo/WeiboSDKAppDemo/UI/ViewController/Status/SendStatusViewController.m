//
//  SendStatusViewController.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-3.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "SendStatusViewController.h"
#import "UICommonCategory.h"
#import "UISystemCommon.h"
#import "UIImage+Scaling.h"
#import "WeiboHomePageViewController.h"

#define MaxWordsCount 140

@interface SendStatusViewController ()

@end

@implementation SendStatusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBarView.title = @"发布微博";
    [self leftBarButtomItemWithNormalName:@"com_goback_up"
                                 highName:@"com_goback_down"
                                 selector:@selector(back)
                                   target:self];
    [self rightBarButtomItemWithNormalName:@"submit_normal"
                                  highName:@"submit_high"
                                  selector:@selector(submit)
                                    target:self];
    
    CGFloat navHeight = self.navigationBarView.frame.size.height;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, navHeight, 320, 180)];
    view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:.3];
    [self.view addSubview:view];
    
    _statusTextView = [[UITextView alloc] initWithFrame:CGRectMake(65, 5, 255, 100)];
    _statusTextView.textColor = [UIColor whiteColor];
    _statusTextView.backgroundColor = [UIColor clearColor];
    _statusTextView.delegate = self;
    _statusTextView.returnKeyType=UIReturnKeyDone;
    _statusTextView.font = [UIFont systemFontOfSize:17.0];
    [_statusTextView becomeFirstResponder];
    [view addSubview:_statusTextView];
    
    _alertCountLabel = [UILabel getLabelWithFontSize:17.0 backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] superView:view];
    _alertCountLabel.text = [NSString stringWithFormat:@"%d个字",MaxWordsCount];
    _alertCountLabel.textAlignment = NSTextAlignmentRight;
    _alertCountLabel.frame = CGRectMake(225, 109, 80, 21);
    
    _pickImageBtn = [UIButton getButtonNormalImage:nil hightImageName:nil selector:@selector(pickImage) target:self supview:view];
    _pickImageBtn.backgroundColor = [UIColor blackColor];
    _pickImageBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_pickImageBtn setTitle:@"添加图片" forState:UIControlStateNormal];
    _pickImageBtn.frame = CGRectMake(5, 5, 60, 60);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
	// Do any additional setup after loading the view.
}

- (void)initViews
{
    
}

- (void)submit
{
    if ([_statusTextView.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入内容" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alert show];
    }else{
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"发送带图片的微博",@"发送普通微博", nil];
        actionsheet.tag = 1001;
        [actionsheet showInView:self.view];
    }
}

- (void)pickImage
{
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"本地相册",@"拍照", nil];
    actionsheet.tag = 1000;
    [actionsheet showInView:self.view];
}

- (void)tap
{
    if ([_statusTextView isFirstResponder]) {
        [_statusTextView resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePickerControllerDelegate,UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    DismissPresentController(self,picker,YES);
    @autoreleasepool {
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:@"public.image"]){
            UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
            CGFloat aQuality = 0.65;
            CGFloat rate = 0.8;
            _imageData = UIImagePNGRepresentation(image);
            CGSize imageSize = image.size;
            while([_imageData length]> 1024*1024*5){
                //第二次开始压缩分辨率和质量
                image = [image scaledImageWithWidth:imageSize.width * rate andHeight:imageSize.height * rate];
                _imageData = UIImageJPEGRepresentation(image, aQuality);
                rate *= 0.8;
            }
            [_pickImageBtn setBackgroundImage:image forState:UIControlStateNormal];
            [_pickImageBtn setTitle:@"" forState:UIControlStateNormal];
        }
    }
}

#pragma mark -UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 1000:
        {
            switch (buttonIndex) {
                case 0:
                {
                    [UISystemCommon LocalPhotoWithCallbackController:self];
                }
                    break;
                case 1:
                {
                    [UISystemCommon takePhotoWithCallbackController:self];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1001:
        {
            switch (buttonIndex) {
                case 0:
                {
                    if (_imageData) {
                        [self.loadingView setLoadingText:@"正在发送请稍后"];
                        [self.loadingView showInView:self.view forceWait:YES];
                        [[StatusManager sharedStatusManager] statusesUpload:_statusTextView.text
                                                                  imageData:_imageData
                                                                    visible:0
                                                                     listId:nil
                                                                   latitude:0
                                                                  longitude:0
                                                                annotations:nil
                                                                   delegate:self];
                    }else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选取图片" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
                        [alert show];
                    }
                }
                    break;
                case 1:
                {
                    [self.loadingView setLoadingText:@"正在发送请稍后"];
                    [self.loadingView showInView:self.view forceWait:YES];
                    NSString *userStr = @"hello";
                    [[StatusManager sharedStatusManager] statusesUpdate:_statusTextView.text
                                                                visible:0
                                                                 listId:nil
                                                               latitude:0
                                                              longitude:0
                                                            annotations:[userStr JSONString]
                                                               delegate:self];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag) {
        WeiboHomePageViewController *controller = [[WeiboHomePageViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark -UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length>MaxWordsCount) {
        textView.text = [textView.text substringToIndex:MaxWordsCount];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    NSString *str = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if(str.length>MaxWordsCount){
        return NO;
    }
    _alertCountLabel.text = [NSString stringWithFormat:@"%ld个字",(long)MaxWordsCount - [str length]];
    return YES;
}

#pragma mark--
#pragma mark--UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}

#pragma mark -StatusManagerDelegate

- (void)OnStatusUpdateSuc
{
    [self.loadingView dismissLoadingViewAnimated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送成功，请去首页查看" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
    alert.tag = 1000;
    [alert show];
}

- (void)OnStatusFailed:(NSString *)errorMsg
{
    [self.loadingView dismissLoadingViewAnimated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMsg delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alert show];
}


@end
