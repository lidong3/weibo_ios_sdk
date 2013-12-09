//
//  ShowCommentListViewController.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-5.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "ShowCommentListViewController.h"
#import "WeiboUser.h"
#import "FileManager.h"
#import "CellHelp.h"
#import "ShowViewWindow.h"

@interface ShowCommentListViewController ()

@end

@implementation ShowCommentListViewController

@synthesize statusId;

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
    self.navigationBarView.title = @"评论列表";
    [self leftBarButtomItemWithNormalName:@"com_goback_up"
                                 highName:@"com_goback_down"
                                 selector:@selector(back)
                                   target:self];
    isFirstRequest = YES;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CommentManager sharedCommentManager] registeDelegate:self];
    [[PortraitManager sharedPortraitManager] registeDelegate:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[CommentManager sharedCommentManager] unRegisteDelegate];
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

- (void)requestStatusInterface
{
    [self.loadingView setLoadingText:@"正在请求请稍后"];
    [self.loadingView showInView:self.view forceWait:YES];
    [[CommentManager sharedCommentManager] getCommentListWithStatusId:self.statusId
                                                                count:20
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
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_commentArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CommentCell";
    CommentCell *cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.delegate = self;
    }
    return cell;
}

#pragma mark -UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboComment *comment = [_commentArray objectAtIndex:indexPath.row];
    CommentCell *theCell = (CommentCell *)cell;
    theCell.comment = comment;
    [theCell refrushUIWithComment];
    [theCell refrushUIWithUser];
    NSString *portraitPath = [[PortraitManager sharedPortraitManager] getPortraitWithUserId:comment.user.Id portraitType:PortraitType_thumbnail];
    if (![FileManager isExist:portraitPath]) {
        [[PortraitManager sharedPortraitManager] getPortraitWithUrl:comment.user.profile_image_url userId:comment.user.Id type:PortraitType_thumbnail delegate:self];
    }
    [theCell refrushUIWithPortrait:portraitPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboComment *comment = [_commentArray objectAtIndex:indexPath.row];
    //18 为名字的高度
    return [CommentCell getCommnetCellHeightWithText:comment] + 2 * CellSpace + 18;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -CommentCellDelegate
- (void)OnPortraitClick:(WeiboComment *)comment
{
    NSString *dir = [[FileManager getDocumentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Portrait/%lld",(long long)comment.user.Id]];
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
        [[PortraitManager sharedPortraitManager] getPortraitWithUrl:comment.user.avatar_large userId:comment.user.Id type:PortraitType_big delegate:self];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        isScrolling = NO;
        for (CommentCell *cell in [self.baseTableView visibleCells]){
            [[PortraitManager sharedPortraitManager] getPortraitWithUrl:cell.comment.user.profile_image_url userId:cell.comment.user.Id type:PortraitType_thumbnail delegate:self];
        }
        [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    isScrolling = NO;
    for (CommentCell *cell in [self.baseTableView visibleCells]){
        [[PortraitManager sharedPortraitManager] getPortraitWithUrl:cell.comment.user.profile_image_url userId:cell.comment.user.Id type:PortraitType_thumbnail delegate:self];
    }
}

#pragma mark -CommentManagerDelegate
- (void)OnGetCommentListSuc:(NSArray *)list
{
    [self.loadingView dismissLoadingViewAnimated:YES];
    if ([list count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该微博没有评论" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alert show];
    }else{
        _commentArray = [NSMutableArray arrayWithArray:list];
        [self.baseTableView reloadData];
    }
}

- (void)OnStatusFailed:(NSString *)errorMsg
{
    [self.loadingView dismissLoadingViewAnimated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMsg delegate:self cancelButtonTitle:nil otherButtonTitles:@"返回",@"重新请求", nil];
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
                for (CommentCell *cell in [self.baseTableView visibleCells]){
                    if (cell.comment.user.Id == portrait.userId) {
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


@end
