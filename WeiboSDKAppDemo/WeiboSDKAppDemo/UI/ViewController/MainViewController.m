//
//  MainViewController.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-11-28.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "MainViewController.h"
#import "WeiboSDK.h"
#import "UICommonCategory.h"
#import "Define.h"
#import "UIDeviceCommon.h"
#import "SDKInterfaceListViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    UIButton *authorizeBtn = [UIButton getButtonNormalImage:@"weibo_logon" hightImageName:nil selector:@selector(authorize) target:self supview:self.view];
    authorizeBtn.frame = CGRectMake((SCREEWIDTH - 280)/2.0, SCREEHEIGHT - kStatusBarHeight - 80, 280, 50);
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationBarView.hidden = YES;
}

- (void)initViews
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Instance Method
- (void)authorize
{
    //必须注册，当和微博客户端交互的时候，需要将应用程序的信息传递给微博客户端
    if ([[RegisterManager sharedRegisterManager] registerApp]) {
#if ForceAuthrize
        [[RegisterManager sharedRegisterManager] authorize:self];
#else
        if (![[RegisterManager sharedRegisterManager] getAppToken]) {
            [[RegisterManager sharedRegisterManager] authorize:self];
        }else{
            SDKInterfaceListViewController *controller = [[SDKInterfaceListViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
#endif
    }else{
        DLog(@"error registerApp failed");
    }
}

#pragma mark -RegisterManagerDelegate
- (void)OnAuthorizeSuc
{
    SDKInterfaceListViewController *controller = [[SDKInterfaceListViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)OnAuthorizeFailed:(NSString *)errorMsg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMsg delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alert show];
}

@end
