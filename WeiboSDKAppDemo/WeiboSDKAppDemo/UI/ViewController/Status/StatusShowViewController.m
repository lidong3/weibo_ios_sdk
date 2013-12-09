//
//  StatusShowViewController.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-5.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "StatusShowViewController.h"
#import "ShowCommentListViewController.h"
#import "WeiboUser.h"
#import "ShowViewWindow.h"
#import "SendStatusViewController.h"

@interface StatusShowViewController ()

@end

@implementation StatusShowViewController

@synthesize status;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBarView.title = [self.status.text substringToIndex:5];
    [self leftBarButtomItemWithNormalName:@"com_goback_up"
                                 highName:@"com_goback_down"
                                 selector:@selector(back)
                                   target:self];
    
    NSString *portraitPath = [[PortraitManager sharedPortraitManager] getPortraitWithUserId:self.status.user.Id portraitType:PortraitType_thumbnail];
    UIButton *portraitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    portraitBtn.frame = CGRectMake(10, kNavigationBarHeight + 10, 60, 60);
    [portraitBtn setBackgroundImage:[UIImage imageWithContentsOfFile:portraitPath] forState:UIControlStateNormal];
    [portraitBtn addTarget:self action:@selector(portraitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:portraitBtn];
    
    UILabel *userNameLabel = [UILabel getLabelWithFontSize:17.0 backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] superView:self.view];
    userNameLabel.text = self.status.user.screen_name;
    userNameLabel.frame = CGRectMake(80, kNavigationBarHeight + 29.5, 230, 21);
    
    CGSize textSize = [status.text sizeWithFont:[UIFont systemFontOfSize:17.0] constrainedToSize:CGSizeMake(SCREEWIDTH, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, kNavigationBarHeight + 80, self.view.bounds.size.width, textSize.height + 10)];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.textView];
    self.textView.text = [self.status text];
    
    UIButton *friendshipsCreateBtn = [UIButton getButtonNormalImage:nil hightImageName:nil selector:@selector(friendshipsCreate) target:self supview:self.view];
    friendshipsCreateBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [friendshipsCreateBtn setBackgroundColor:[UIColor lightGrayColor]];
    [friendshipsCreateBtn setTitle:@"添加关注" forState:UIControlStateNormal];
    [friendshipsCreateBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    friendshipsCreateBtn.frame = CGRectMake(110, self.textView.frame.origin.y + self.textView.frame.size.height, 60, 40);
    
    UIButton *friendshipsDestoryBtn = [UIButton getButtonNormalImage:nil hightImageName:nil selector:@selector(friendshipsDestory) target:self supview:self.view];
    friendshipsDestoryBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [friendshipsDestoryBtn setBackgroundColor:[UIColor lightGrayColor]];
    [friendshipsDestoryBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    [friendshipsDestoryBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    friendshipsDestoryBtn.frame = CGRectMake(180, self.textView.frame.origin.y + self.textView.frame.size.height, 60, 40);
    
    UIButton *commentCreateBtn = [UIButton getButtonNormalImage:nil hightImageName:nil selector:@selector(comment) target:self supview:self.view];
    commentCreateBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [commentCreateBtn setBackgroundColor:[UIColor lightGrayColor]];
    [commentCreateBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentCreateBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    commentCreateBtn.frame = CGRectMake(250, self.textView.frame.origin.y + self.textView.frame.size.height, 60, 40);
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [CommentManager sharedCommentManager].delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [CommentManager sharedCommentManager].delegate = nil;
}

- (void)portraitClick
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"查看个人名片模块正在开发" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alertView show];
}

- (void)friendshipsDestory
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消关注模块正在开发" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alertView show];
}

- (void)friendshipsCreate
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"关注模块正在开发" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alertView show];
}

- (void)comment
{
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"评论",@"查看评论", nil];
    actionsheet.tag = 1001;
    [actionsheet showInView:self.view];
}

- (void)toComment
{
    if (_commentPopView == nil) {
        _commentPopView = [[CommentPopView alloc] initWithFrame:CGRectMake(0, 0, 272, 180)];
        _commentPopView.delegate = self;
    }
    [ShowViewWindow showViewInWindow:_commentPopView alpha:0.8 hasMask:YES animation:YES];
}

- (void)initViews
{
    
}

- (void)showCommentList
{
    ShowCommentListViewController *controller = [[ShowCommentListViewController alloc] init];
    controller.statusId = status.Id;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 1001:
        {
            switch (buttonIndex) {
                case 0:
                {
                    //评论
                    [self toComment];
                }
                    break;
                case 1:
                {
                    //查看评论
                    [self showCommentList];
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
    switch (alertView.tag) {
        case 5001:
        {
            switch (buttonIndex) {
                case 1:
                {
                    [self showCommentList];
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

#pragma mark -评论相关
- (void)keyBoardShow:(NSNotification *)notify
{
    CGRect keyboardBounds;
    [[notify.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rc = _commentPopView.frame;
        rc.origin.y = SCREEHEIGHT - (keyboardBounds.size.height + 4) - _commentPopView.frame.size.height;
        _commentPopView.frame = rc;
    }];
}

- (void)keyBoardHidden:(NSNotification *)notify
{
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat defaultY = (SCREEHEIGHT - _commentPopView.frame.size.height)/2.0;
        _commentPopView.frame = CGRectMake(24, defaultY, 272, 180);
    }];
}

#pragma mark -CommentPopViewDelegate
- (void)blessCardLeftEvent
{
    if ([_commentPopView.blessTextView isFirstResponder]) {
        [_commentPopView.blessTextView resignFirstResponder];
    }
    [ShowViewWindow dismissViewInWindowWithAnimation:YES];
}

- (void)blessCardRightEvent:(NSString *)message
{
    if ([message length] > 0) {
        if ([_commentPopView.blessTextView isFirstResponder]) {
            [_commentPopView.blessTextView resignFirstResponder];
        }
        [ShowViewWindow dismissViewInWindowWithAnimation:YES];
        [self.loadingView setLoadingText:@"正在处理请稍候"];
        [self.loadingView showInView:self.view forceWait:YES];
        [[CommentManager sharedCommentManager] commentCreateWithComment:_commentPopView.blessTextView.text statusId:self.status.Id comment_ori:1 delegate:self];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入评论内容" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alertView show];
    }
}

#pragma mark -CommentManagerDelegate
- (void)OnCommentCreateSuc
{
    [self.loadingView dismissLoadingViewAnimated:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论成功，是否查看评论？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"否",@"是", nil];
    alertView.tag = 5001;
    [alertView show];
}

- (void)OnCommentFailed:(NSString *)errorMsg;
{
    [self.loadingView dismissLoadingViewAnimated:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMsg delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alertView show];
}

@end
