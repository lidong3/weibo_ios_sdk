//
//  StatusInterfaceListViewController.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-11-29.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "StatusInterfaceListViewController.h"
#import "StatusPublicTimeLineListViewController.h"
#import "WeiboHomePageViewController.h"

@interface StatusInterfaceListViewController ()

@end

@implementation StatusInterfaceListViewController

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
    self.navigationBarView.title = @"微博相关接口";
    [self leftBarButtomItemWithNormalName:@"com_goback_up"
                                 highName:@"com_goback_down"
                                 selector:@selector(back)
                                   target:self];
    [self initDatas];
	// Do any additional setup after loading the view.
}

- (void)initDatas
{
    if (_listData == nil) {
        _listData = [[NSMutableArray alloc] initWithCapacity:21];
        [_listData addObject:@"获取最新的公共微博"];
        [_listData addObject:@"获取当前登录用户及其所关注用户的最新微博"];
//        [_listData addObject:@"获取当前登录用户及其所关注用户的最新微博"];
//        [_listData addObject:@"获取当前登录用户及其所关注用户的最新微博的ID"];
//        [_listData addObject:@"获取用户发布的微博"];
//        [_listData addObject:@"批量获取指定的一批用户的微博列表"];
//        [_listData addObject:@"返回一条原创微博的最新转发微博"];
//        [_listData addObject:@"获取一条原创微博的最新转发微博的ID"];
//        [_listData addObject:@"获取@当前用户的最新微博"];
//        [_listData addObject:@"获取@当前用户的最新微博的ID"];
//        [_listData addObject:@"获取双向关注用户的最新微博"];
//        [_listData addObject:@"根据ID获取单条微博信息"];
//        [_listData addObject:@"根据微博ID批量获取微博信息"];
//        [_listData addObject:@"通过id获取mid"];
//        [_listData addObject:@"通过mid获取id"];
//        [_listData addObject:@"批量获取指定微博的转发数评论数"];
//        [_listData addObject:@"获取当前登录用户关注的人发给其的定向微博"];
//        [_listData addObject:@"获取当前登录用户关注的人发给其的定向微博ID列表"];
//        [_listData addObject:@"根据ID跳转到单条微博页"];
//        [_listData addObject:@"获取官方表情"];
//        [_listData addObject:@"转发一条微博信息"];
//        [_listData addObject:@"删除微博信息"];
//        [_listData addObject:@"发布一条微博信息"];
//        [_listData addObject:@"获取当前登录用户关注的人发给其的定向微博ID列表"];
//        [_listData addObject:@"上传图片并发布一条微博"];
//        [_listData addObject:@"发布一条微博同时指定上传的图片或图片url"];
//        [_listData addObject:@"屏蔽某条微博"];
//        [_listData addObject:@"屏蔽某个@我的微博及后续由其转发引起的@提及"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listData count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"SDKInterfaceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    return cell;
}

#pragma mark -UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [_listData objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //进入微博接口列表
            StatusPublicTimeLineListViewController *controller = [[StatusPublicTimeLineListViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
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

@end
