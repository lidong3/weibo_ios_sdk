//
//  MyLoadingView.m
//  tanzhi
//
//  Created by Chen Lei on 11-7-22.
//  Copyright 2011年 ä¸­è½¯æ³°å. All rights reserved.
//

#import "MyLoadingView.h"

@implementation MyLoadingView 

- (id)init
{
    self = [super initWithFrame:CGRectMake(100, 180, 120, 120)];
    if (self) 
    {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            self.frame = CGRectMake(320, [UIScreen mainScreen].bounds.size.height, 120, 120);
        }
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0,0,120, 120)];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.5;
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 10;
        backView.layer.borderWidth = 0;
        [self addSubview:backView];
        [backView release];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
        self.layer.borderWidth = 0;
        
        activityView1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activityView1 setFrame:CGRectMake(44, 34, 32, 32)];
        activityView1.hidden = NO;
        [activityView1 startAnimating];
        [self addSubview:activityView1];
        [activityView1 release];
        
        failedImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Upload-Download-Failure@2x.png"]];
        failedImageView.frame=CGRectMake(44, 34, 32, 32);
        failedImageView.hidden=YES;
        [self addSubview:failedImageView];
        [failedImageView release];
        
        successImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Upload-success@2x.png"]];
        successImageView.frame=CGRectMake(44, 34, 32, 32);
        successImageView.hidden= YES;
        [self addSubview:successImageView];
        [successImageView release];
        
        loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, 115, 35)];
        loadingLabel.font = [UIFont systemFontOfSize:16];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
            [loadingLabel setTextAlignment:NSTextAlignmentCenter];
            loadingLabel.minimumFontSize = 12;
        }else{
            [loadingLabel setTextAlignment:NSTextAlignmentCenter];
        }
        
        loadingLabel.backgroundColor = [UIColor clearColor];
        loadingLabel.textColor = [UIColor whiteColor];
        loadingLabel.numberOfLines = 2;
        loadingLabel.adjustsFontSizeToFitWidth = YES;
        loadingLabel.numberOfLines = 0;
        [self addSubview:loadingLabel];
        [loadingLabel release];
    }
    return self;
}

- (id)initWithTitle:(NSString *)loadingTitle 
//使用此控件， 可以一次初始化添加，多次调用，最后viewDisappear时 需要调用dismissLoadingView方法，移除视图
{
    self = [super initWithFrame:CGRectMake(100, 180, 120, 120)];
    if (self)
    {
        // Initialization code
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;

        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0,0,120, 120)];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.5;
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 10;
        backView.layer.borderWidth = 0;
        [self addSubview:backView];
        [backView release];
        
        activityView1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activityView1 setFrame:CGRectMake(44, 34, 32, 32)];
        activityView1.hidesWhenStopped =YES;
        activityView1.hidden =NO;
        [activityView1 startAnimating];
        [self addSubview:activityView1];
        [activityView1 release];
        
        failedImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Upload-Download-Failure@2x.png"]];
        failedImageView.frame=CGRectMake(44, 34, 32, 32);
        failedImageView.hidden=YES;
        [self addSubview:failedImageView];
        [failedImageView release];
        
        successImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Upload-success@2x.png"]];
        successImageView.frame=CGRectMake(44, 34, 32, 32);
        successImageView.hidden= YES;
        [self addSubview:successImageView];
        [successImageView release];
        
        loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 80, 115, 35)];
        loadingLabel.text = loadingTitle;
        loadingLabel.numberOfLines = 1;
        loadingLabel.font = [UIFont systemFontOfSize:16];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
            [loadingLabel setTextAlignment:NSTextAlignmentCenter];
            loadingLabel.minimumFontSize = 12;
        }else{
            [loadingLabel setTextAlignment:NSTextAlignmentCenter];
        }
        loadingLabel.backgroundColor = [UIColor clearColor];
        loadingLabel.textColor = [UIColor whiteColor];
        loadingLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:loadingLabel];
        [loadingLabel release];
    }
    return self;
}
-(void)setHideActivityIndicatorViewOrNot:(BOOL)isHide isSuccess:(BOOL)success{
    if (success) {
        [activityView1 stopAnimating];
        activityView1.hidden=YES;
        failedImageView.hidden = YES;
        successImageView.hidden = NO;
    }
    else if (isHide==YES) {
        [activityView1 stopAnimating];
        activityView1.hidden=YES;
        failedImageView.hidden=NO;
        successImageView.hidden = YES;
    }else{
        [activityView1 startAnimating];
        activityView1.hidden=NO;
        failedImageView.hidden=YES;
        successImageView.hidden =YES;
    }
}
-(NSString *)getLoadingText
{
    return loadingLabel.text;
}

-(void)setLoadingText:(NSString *)text
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(110, 1000) lineBreakMode:NSLineBreakByWordWrapping];
#else
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(110, 1000) lineBreakMode:UILineBreakModeWordWrap]
#endif
    if (textSize.height>35) {
        [loadingLabel setFont:[UIFont systemFontOfSize:14]];
        [loadingLabel setFrame:CGRectMake(5, 50, 110, 80)];
        [failedImageView setFrame:CGRectMake(44, 24, 32, 32)];
        [successImageView setFrame:CGRectMake(44, 24, 32, 32)];
    }
    
    [loadingLabel setText:text];
}

- (void)showInView:(UIView *)view forceWait:(BOOL)wait
{
//    UIWindow *window = nil;
//    if (view)
//    {
//        window = view.window ? view.window : [UIApplication sharedApplication].keyWindow;//;
//    }
//    else
//    {
////        window = [[[UIApplication sharedApplication] delegate] window];
//        window = [UIApplication sharedApplication].keyWindow;
//    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (wait)
    {
        if(_mask == nil)
        {
            _mask = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            _mask.backgroundColor = [UIColor blackColor];  // blackColor
            _mask.alpha = 0.02;
        }
        
        [window addSubview:_mask];   
    }
    
    self.alpha = .8;
    [window addSubview:self];
    
    CGPoint point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
    self.center = point;
}

- (void)showInView:(UIView *)view
{
    [self showInView:view forceWait:NO];
}

-(void)setmaskAlpha:(CGFloat)malpha
{
    _mask.alpha = malpha;
}

- (void)dismissAnimationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self removeFromSuperview];
    [_mask removeFromSuperview];
    _mask = nil;
} 

- (void)dismissPopupViewAnimated:(BOOL)animated 
{
    if(animated)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.35];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(dismissAnimationDidStop:finished:)];
        _mask.alpha = 0;
        self.alpha = 0;
        //self.frame =  CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];
    }
    else 
    {
        [self dismissAnimationDidStop:nil finished:YES];
    }
}

- (void) dismissLoadingView
{ 
    [self dismissPopupViewAnimated:YES];
}

- (void) dismissLoadingViewAnimated:(BOOL)animated
{ 
    [self dismissPopupViewAnimated:animated];
}

- (void)dealloc
{
    [super dealloc];
}

@end
