//
//  StatusPublicTimeLineListViewController.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-11-29.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "StatusPublicTimeLineListViewController.h"
#import "WeiboStatus.h"
#import "StatusPublicTimeLineViewController.h"
#import "PortraitManager.h"
#import "WeiboUser.h"
#import "FileManager.h"
#import "CellHelp.h"
#import "ShowViewWindow.h"
#import "StatusShowViewController.h"
#import "WeiboHomePageViewController.h"

@interface StatusPublicTimeLineListViewController ()

@end

@implementation StatusPublicTimeLineListViewController

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
    self.navigationBarView.title = @"最新的公共微博列表";
    [self leftBarButtomItemWithNormalName:@"com_goback_up"
                                 highName:@"com_goback_down"
                                 selector:@selector(back)
                                   target:self];
    
    isFirstRequest = YES;
	// Do any additional setup after loading the view.
}

- (void)initViews
{
    self.isSupportRefreshView = YES;
    [super initViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[StatusManager sharedStatusManager] registeDelegate:self];
    [[PortraitManager sharedPortraitManager] registeDelegate:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[StatusManager sharedStatusManager] unRegisteDelegate];
    [[PortraitManager sharedPortraitManager] unRegisteDelegate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (isFirstRequest) {
        isFirstRequest = NO;
        [self requestStatusInterface];
    }
}

- (void)back
{
    NSString *dir = [[FileManager getDocumentPath] stringByAppendingPathComponent:@"Portrait"];
    [FileManager removeDic:dir];
    dir = [[FileManager getDocumentPath] stringByAppendingPathComponent:@"Status"];
    [FileManager removeDic:dir];
    [super back];
}

- (void)toComment
{
    if (_commentPopView == nil) {
        _commentPopView = [[CommentPopView alloc] initWithFrame:CGRectMake(0, 0, 272, 180)];
        _commentPopView.delegate = self;
    }
    [ShowViewWindow showViewInWindow:_commentPopView alpha:0.8 hasMask:YES animation:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -request

- (void)requestStatusInterface
{
    [self.loadingView setLoadingText:@"正在请求请稍后"];
    [self.loadingView showInView:self.view forceWait:YES];
    [[StatusManager sharedStatusManager] getStatusPublicTimeLineWithCount:20
                                                                 delegate:self];
}

#pragma mark -UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 1000:
        {
            switch (buttonIndex) {
                case 1:
                {
                    WeiboHomePageViewController *controller = [[WeiboHomePageViewController alloc] init];
                    [self.navigationController pushViewController:controller animated:YES];
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

#pragma mark -UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 1002:
        {
            switch (buttonIndex) {
                case 0:
                {
                    [self.loadingView setLoadingText:@"正在处理请稍候"];
                    [self.loadingView showInView:self.view forceWait:YES];
                    [[StatusManager sharedStatusManager] statusRepostWithStatusId:_curCommentStatus.Id statusText:_curCommentStatus.text is_comment:commentType delegate:self];
                }
                    break;
                case 1:
                {
                    commentType = 1;
                }
                    break;
                case 2:
                {
                    commentType = 2;
                }
                    break;
                case 3:
                {
                    commentType = 3;
                }
                    break;
                    
                default:
                    break;
            }
            if (buttonIndex != 4) {
                [self toComment];
            }
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_statusArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"SDKInterfaceCell";
    StatusCell *cell = (StatusCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.delegate = self;
    }
    return cell;
}

#pragma mark -UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboStatus *status = [_statusArray objectAtIndex:indexPath.row];
    StatusCell *theCell = (StatusCell *)cell;
    theCell.status = status;
    [theCell refrushUIWithStatus];
    [theCell refrushUIWithUser];
    NSString *portraitPath = [[PortraitManager sharedPortraitManager] getPortraitWithUserId:status.user.Id portraitType:PortraitType_thumbnail];
    if (![FileManager isExist:portraitPath]) {
        [[PortraitManager sharedPortraitManager] getPortraitWithUrl:status.user.profile_image_url userId:status.user.Id type:PortraitType_thumbnail delegate:self];
    }
    [theCell refrushUIWithPortrait:portraitPath];
    if ([status.pic_urls count] > 0) {
        NSString *sourcePath = [[StatusManager sharedStatusManager] getThumbImageWithStatusId:status.Id];
        if (![FileManager isExist:sourcePath]) {
            [[StatusManager sharedStatusManager] getStatusContentImageWithStatusId:status.Id
                                                                               url:[[status.pic_urls objectAtIndex:0] objectForKey:@"thumbnail_pic"]
                                                                          delegate:self];
        }
    }
    [theCell refrushUIWithSourceImage];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboStatus *status = [_statusArray objectAtIndex:indexPath.row];
    //18 为名字的高度
    return [StatusCell getStatusCellHeightWithText:status] + 2 * CellSpace + 18;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusShowViewController *controller = [[StatusShowViewController alloc] init];
    controller.status = [_statusArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self requestStatusInterface];
}

#pragma mark -StatusCellDelegate
- (void)OnPortraitClick:(WeiboStatus *)status
{
    NSString *dir = [[FileManager getDocumentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Portrait/%lld",(long long)status.user.Id]];
    NSString *filePath = [dir stringByAppendingPathComponent:@"portrait_big"];
    if ([FileManager isExist:filePath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        if (_bigImageView == nil) {
            _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        }
        _bigImageView.image = image;
        _bigImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [ShowViewWindow showViewInWindow:_bigImageView alpha:0.8 hasMask:YES animation:YES];
        [ShowViewWindow supportTapToDismiss];
    }else{
        [[PortraitManager sharedPortraitManager] getPortraitWithUrl:status.user.avatar_large userId:status.user.Id type:PortraitType_big delegate:self];
    }
}

- (void)OnSourceClick:(WeiboStatus *)status
{
    NSString *filePath = [[StatusManager sharedStatusManager] getBigImageWithStatusId:status.Id];
    if ([FileManager isExist:filePath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        if (_bigImageView == nil) {
            _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        }
        _bigImageView.image = image;
        _bigImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [ShowViewWindow showViewInWindow:_bigImageView alpha:0.8 hasMask:YES animation:YES];
        [ShowViewWindow supportTapToDismiss];
    }else{
        [[StatusManager sharedStatusManager] getStatusContentBigImageWithStatusId:status.Id url:status.original_pic delegate:self];
    }
}

- (void)OnTransmitCallback:(WeiboStatus *)status
{
    _curCommentStatus = status;
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"是否在转发的同时发表评论？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"不发表评论",@"评论给当前微博",@"评论给原微博",@"都评论", nil];
    actionsheet.tag = 1002;
    [actionsheet showInView:self.view];
}

- (void)OnCommentCallback:(WeiboStatus *)status
{
    
}

- (void)OnCollectCallback:(WeiboStatus *)status
{
    
}

- (void)OnJsonCallback:(WeiboStatus *)status
{
    StatusPublicTimeLineViewController *controller = [[StatusPublicTimeLineViewController alloc] init];
    controller.status = status;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)OnDeleteCallback:(WeiboStatus *)status
{
    [[StatusManager sharedStatusManager] deleteStatusWithUserId:status.Id delegate:self];
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    isScrolling = YES;
    [super scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        isScrolling = NO;
        for (StatusCell *cell in [self.baseTableView visibleCells]){
            [[PortraitManager sharedPortraitManager] getPortraitWithUrl:cell.status.user.profile_image_url userId:cell.status.user.Id type:PortraitType_thumbnail delegate:self];
        }
        [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    isScrolling = NO;
    for (StatusCell *cell in [self.baseTableView visibleCells]){
        [[PortraitManager sharedPortraitManager] getPortraitWithUrl:cell.status.user.profile_image_url userId:cell.status.user.Id type:PortraitType_thumbnail delegate:self];
    }
}

#pragma mark -StatusManagerDelegate
- (void)OnGetStatusPublicTimeLineSuc:(NSArray *)statuses
{
    [self.loadingView dismissLoadingViewAnimated:YES];
    _statusArray = [NSMutableArray arrayWithArray:statuses];
    [self.baseTableView reloadData];
    if (_slimeView.loading) {
        [_slimeView performSelector:@selector(endRefresh)
                         withObject:nil afterDelay:0.5
                            inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    }
}

- (void)OnGetStatusContentImageSuc:(NSString *)filePath
                          statusId:(long long)Id
{
    if (!isScrolling) {
        for (StatusCell *cell in [self.baseTableView visibleCells]){
            if (cell.status.Id == Id) {
                [self.baseTableView beginUpdates];
                [cell refrushUIWithSourceImage];
                [self.baseTableView endUpdates];
            }
        }
    }
}

- (void)OnGetStatusContentBigImageSuc:(NSString *)filePath statusId:(long long)Id
{
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (_bigImageView == nil) {
        _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    }
    _bigImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    _bigImageView.image = image;
    [ShowViewWindow showViewInWindow:_bigImageView alpha:0.8 hasMask:YES animation:YES];
    [ShowViewWindow supportTapToDismiss];
}

- (void)OnReportStatusSuc
{
    [self.loadingView dismissLoadingViewAnimated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"转发成功，是否刷新查看？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"否",@"是", nil];
    alert.tag = 1000;
    [alert show];
}

- (void)OnStatusFailed:(NSString *)errorMsg
{
    [self.loadingView dismissLoadingViewAnimated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMsg delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alert show];
}

#pragma mark -PortraitManagerDelegate
- (void)OnPortraitFailed:(NSString *)errorMsg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMsg delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alert show];
}

- (void)OnPortraitSuc:(Portrait *)portrait
{
    switch (portrait.type) {
        case PortraitType_thumbnail:
        {
            if (!isScrolling) {
                for (StatusCell *cell in [self.baseTableView visibleCells]){
                    if (cell.status.user.Id == portrait.userId) {
                        [cell refrushUIWithPortrait:portrait.thumbnailPath];
                    }
                }
            }
        }
            break;
        case PortraitType_big:
        {
            UIImage *image = [UIImage imageWithContentsOfFile:portrait.bigPath];
            if (_bigImageView == nil) {
                _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
            }
            _bigImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            _bigImageView.image = image;
            [ShowViewWindow showViewInWindow:_bigImageView alpha:0.8 hasMask:YES animation:YES];
            [ShowViewWindow supportTapToDismiss];
        }
            break;
        case PortraitType_hd:
        {
            
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
        [[StatusManager sharedStatusManager] statusRepostWithStatusId:_curCommentStatus.Id statusText:_curCommentStatus.text is_comment:commentType delegate:self];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入评论内容" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alertView show];
    }
}


@end
