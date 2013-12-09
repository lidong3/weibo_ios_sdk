//
//  StatusUserTimeLineListViewController.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-3.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "StatusUserTimeLineListViewController.h"
#import "WeiboStatus.h"
#import "StatusPublicTimeLineViewController.h"
#import "PortraitManager.h"
#import "WeiboUser.h"
#import "FileManager.h"
#import "CellHelp.h"
#import "ShowViewWindow.h"

@interface StatusUserTimeLineListViewController ()

@end

@implementation StatusUserTimeLineListViewController

@synthesize user;

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
    self.navigationBarView.title = @"首页微博列表";
    [self leftBarButtomItemWithNormalName:@"com_goback_up"
                                 highName:@"com_goback_down"
                                 selector:@selector(back)
                                   target:self];
    isFirstRequest = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[StatusManager sharedStatusManager] registeDelegate:self];
    [[PortraitManager sharedPortraitManager] registeDelegate:self];
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
    [[StatusManager sharedStatusManager] getStatusUserTimeLineWithCount:20
                                                                 userId:self.user.Id
                                                               delegate:self];
}

#pragma mark -UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self back];
        }
            break;
        case 1:
        {
            [self requestStatusInterface];
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
    return [StatusCell getStatusCellHeightWithText:status] + 2 * CellSpace;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -StatusCellDelegate
- (void)OnPortraitClick:(WeiboStatus *)status
{
    NSString *dir = [[FileManager getDocumentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Portrait/%lld",(long long)status.user.Id]];
    NSString *filePath = [dir stringByAppendingPathComponent:@"portrait_big"];
    if ([FileManager isExist:filePath]) {
        if (_bigImageView == nil) {
            _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        }
        _bigImageView.image = [UIImage imageWithContentsOfFile:filePath];
        [ShowViewWindow showViewInWindow:_bigImageView alpha:0.8 hasMask:YES animation:YES];
        [ShowViewWindow supportTapToDismiss];
    }else{
        [[PortraitManager sharedPortraitManager] getPortraitWithUrl:status.user.avatar_large userId:status.user.Id type:PortraitType_big delegate:self];
    }
}

- (void)OnSourceClick:(WeiboStatus *)status
{
    NSString *filePath = [[StatusManager sharedStatusManager] getThumbImageWithStatusId:status.Id];
    if ([FileManager isExist:filePath]) {
        if (_bigImageView == nil) {
            _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        }
        _bigImageView.image = [UIImage imageWithContentsOfFile:filePath];
        [ShowViewWindow showViewInWindow:_bigImageView alpha:0.8 hasMask:YES animation:YES];
        [ShowViewWindow supportTapToDismiss];
    }
}

- (void)OnTransmitCallback:(WeiboStatus *)status
{
    
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
            if ([cell.status.pic_urls count] > 0) {
                [[StatusManager sharedStatusManager] getStatusContentImageWithStatusId:cell.status.Id
                                                                                   url:[[cell.status.pic_urls objectAtIndex:0] objectForKey:@"thumbnail_pic"]
                                                                              delegate:self];
            }
        }
    }
    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    isScrolling = NO;
    for (StatusCell *cell in [self.baseTableView visibleCells]){
        [[PortraitManager sharedPortraitManager] getPortraitWithUrl:cell.status.user.profile_image_url userId:cell.status.user.Id type:PortraitType_thumbnail delegate:self];
        if ([cell.status.pic_urls count] > 0) {
            if ([cell.status.pic_urls count] > 0) {
                [[StatusManager sharedStatusManager] getStatusContentImageWithStatusId:cell.status.Id
                                                                                   url:[[cell.status.pic_urls objectAtIndex:0] objectForKey:@"thumbnail_pic"]
                                                                              delegate:self];
            }
        }
    }
}

#pragma mark -StatusManagerDelegate
- (void)OnGetStatusUserTimeLineSuc:(NSArray *)statuses
{
    [self.loadingView dismissLoadingViewAnimated:YES];
    _statusArray = [NSMutableArray arrayWithArray:statuses];
    [self.baseTableView reloadData];
}

- (void)OnStatusFailed:(NSString *)errorMsg
{
    [self.loadingView dismissLoadingViewAnimated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMsg delegate:self cancelButtonTitle:nil otherButtonTitles:@"返回",@"重新请求", nil];
    [alert show];
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
            if (_bigImageView == nil) {
                _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
            }
            _bigImageView.image = [UIImage imageWithContentsOfFile:portrait.bigPath];
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

@end
