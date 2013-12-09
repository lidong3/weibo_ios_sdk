//
//  SDKInterfaceListViewController.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-11-29.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "SDKInterfaceListViewController.h"
#import "StatusInterfaceListViewController.h"

@interface SDKInterfaceListViewController ()

@end

@implementation SDKInterfaceListViewController

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
    self.navigationBarView.title = @"微博SDK接口类别";
    [self leftBarButtomItemWithNormalName:@"com_goback_up"
                                 highName:@"com_goback_down"
                                 selector:@selector(back)
                                   target:self];
    //初始化数据
    [self initDatas];
    
	// Do any additional setup after loading the view.
}

- (void)initDatas
{
    if (_listData == nil) {
        _listData = [[NSMutableArray alloc] initWithCapacity:21];
        [_listData addObject:@"微博"];
//        [_listData addObject:@"评论"];
//        [_listData addObject:@"用户"];
//        [_listData addObject:@"注册"];
//        [_listData addObject:@"账号"];
//        [_listData addObject:@"收藏"];
//        [_listData addObject:@"好友分组"];
//        [_listData addObject:@"话题"];
//        [_listData addObject:@"微博标签"];
//        [_listData addObject:@"用户标签"];
//        [_listData addObject:@"搜索"];
//        [_listData addObject:@"推荐"];
//        [_listData addObject:@"通知"];
//        [_listData addObject:@"公共服务"];
//        [_listData addObject:@"位置服务"];
//        [_listData addObject:@"地理服务"];
//        [_listData addObject:@"短链"];
//        [_listData addObject:@"置顶微博"];
//        [_listData addObject:@"关系"];
//        [_listData addObject:@"邀请"];
//        [_listData addObject:@"粉丝服务"];
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
            StatusInterfaceListViewController *controller = [[StatusInterfaceListViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
