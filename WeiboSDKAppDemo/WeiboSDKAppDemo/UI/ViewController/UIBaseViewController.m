//
//  UIBaseViewController.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-11-29.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UIBaseViewController.h"

@interface UIBaseViewController ()

@end

@implementation UIBaseViewController

@synthesize baseTableView = _baseTableView;
@synthesize loadingView;
@synthesize isSupportRefreshView = _isSupportRefreshView;
@synthesize tableViewIsGroupStyle = _tableViewIsGroupStyle;
@synthesize textView;
@synthesize navigationBarView = _navigationBarView;

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
    
    self.navigationBarView = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEWIDTH, kNavigationBarHeight)];
    self.navigationBarView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.navigationBarView];
    
    self.loadingView = [[MyLoadingView alloc] init];
    [self initViews];
	// Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationBarView setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationBarView setHidden:NO];
}

- (void)initViews
{
    if (_tableViewIsGroupStyle) {
        self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.navigationBarView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationBarView.frame.size.height) style:UITableViewStyleGrouped];
    }else{
        self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.navigationBarView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationBarView.frame.size.height) style:UITableViewStylePlain];
    }
    
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.baseTableView.dataSource = self;
    self.baseTableView.delegate = self;
    [self.view addSubview:self.baseTableView];
    
    if (_isSupportRefreshView) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = [UIDeviceCommon isIOS7]?0:0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor blackColor];
        _slimeView.slime.skinColor = [UIColor whiteColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor blackColor];
        [self.baseTableView addSubview:_slimeView];
    }
}

- (void)requestInterface
{
    //子类实现
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftBarButtomItemWithNormalName:(NSString*)normalName
                               highName:(NSString *)highName
                               selector:(SEL)selector
                                 target:(id)target
{
    NSString *path = [NSString stringWithFormat:@"%@.png", normalName];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage imageNamed:path];
    if ([UIDeviceCommon isIOS7]) {
        leftButton.frame = CGRectMake(3, 20, 44, 44);
    }else{
        leftButton.frame = CGRectMake(3, 0, 44, 44);
    }
    [leftButton setImage:normalImage forState:UIControlStateNormal];
    path = [NSString stringWithFormat:@"%@.png", highName];
    [leftButton setImage:[UIImage imageNamed:path] forState:UIControlStateHighlighted];
    [leftButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [_navigationBarView setLeftBtn:leftButton];
}

- (void)rightBarButtomItemWithNormalName:(NSString*)normalName
                                highName:(NSString *)highName
                                selector:(SEL)selector
                                  target:(id)target
{
    NSString *path = [NSString stringWithFormat:@"%@.png", normalName];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage imageNamed:path];
    if ([UIDeviceCommon isIOS7]) {
        rightButton.frame = CGRectMake(273, 20, 44, 44);
    }else{
        rightButton.frame = CGRectMake(273, 0, 44, 44);
    }
    [rightButton setImage:normalImage forState:UIControlStateNormal];
    path = [NSString stringWithFormat:@"%@.png", highName];
    [rightButton setImage:[UIImage imageNamed:path] forState:UIControlStateHighlighted];
    [rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [_navigationBarView setRightBtn:rightButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    //子类实现
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
// fixed font style. use custom view (UILabel) if you want something different
{
    return @"";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"";
}

//单元格返回的编辑风格，包括删除 添加 和 默认  和不可编辑三种风格

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_IsTableViewEdit) {
        return YES;
    }else{
        return NO;
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}
@end
