//
//  StatusPublicTimeLineViewController.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-11-29.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "StatusPublicTimeLineViewController.h"
#import "WeiboStatus.h"

@interface StatusPublicTimeLineViewController ()

@end

@implementation StatusPublicTimeLineViewController

@synthesize status;

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
    self.navigationBarView.title = [self.status.text length] > 5 ? [self.status.text substringToIndex:5]:self.status.text;
    [self leftBarButtomItemWithNormalName:@"com_goback_up"
                                 highName:@"com_goback_down"
                                 selector:@selector(back)
                                   target:self];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, kNavigationBarHeight, self.view.bounds.size.width, SCREEHEIGHT - kStatusBarHeight - kNavigationBarHeight)];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.textView];
    self.textView.text = [self.status description];
}

- (void)initViews
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
