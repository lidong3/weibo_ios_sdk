//
//  MenuImageView.m
//  RCS
//
//  Created by qxxw_a_n on 13-9-22.
//  Copyright (c) 2013年 feinno. All rights reserved.
//

#import "MenuImageView.h"

@interface MenuImageView ()
@end

@implementation MenuImageView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
        [longPress release];
    }
    return self;
}

- (void)addMenuItemByID:(NSString *)ID
{
    if (_menuItems == nil){
        _menuItems = [[NSMutableArray alloc] initWithCapacity:5];
    }
    UIMenuItem *item = nil;
    if ([ID isEqualToString:TransmitID]) {
        item = [[UIMenuItem alloc] initWithTitle:TransmitID action:@selector(transmit)];
    }else if ([ID isEqualToString:CommentID]){
        item = [[UIMenuItem alloc] initWithTitle:CommentID action:@selector(comment)];
    }else if ([ID isEqualToString:CollectID]){
        item = [[UIMenuItem alloc] initWithTitle:CollectID action:@selector(collect)];
    }else if ([ID isEqualToString:ShowJsonID]){
        item = [[UIMenuItem alloc] initWithTitle:ShowJsonID action:@selector(showJson)];
    }else if ([ID isEqualToString:DeleteID]){
        item = [[UIMenuItem alloc] initWithTitle:DeleteID action:@selector(delete)];
    }
    else{
        NSLog(@"出现了未定义的menuID");
        item = [[UIMenuItem alloc] initWithTitle:@"其他" action:@selector(other)];
    }
    [_menuItems addObject:item];
    [item release];
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if ([gesture state] == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        //得到菜单栏
        menuController = [UIMenuController sharedMenuController];
        //设置菜单
        
        [menuController setMenuItems:_menuItems];
        //设置菜单栏位置
        [menuController setTargetRect:self.bounds inView:self];
        
        //显示菜单栏
        [menuController setMenuVisible:YES animated:YES];
    }
}

#pragma mark -
#pragma mark -MenuEvent

- (void)transmit
{
    //不要在这里面处理逻辑，因为很多地方要用到，在它的回调的地方用
    [self resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(OnTransmitCallback)]) {
        [_delegate OnTransmitCallback];
    }
}

- (void)comment
{
    [self resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(OnCommentCallback)]) {
        [_delegate OnCommentCallback];
    }
}

- (void)collect
{
    [self resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(OnCollectCallback)]) {
        [_delegate OnCollectCallback];
    }
}

- (void)showJson
{
    [self resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(OnJsonCallback)]) {
        [_delegate OnJsonCallback];
    }
}

- (void)delete
{
    [self resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(OnDeleteCallback)]) {
        [_delegate OnDeleteCallback];
    }
}

- (void)other
{
    NSLog(@"menuOther  ");
}

//能否更改FirstResponder,一般视图默认为NO,必须重写为YES
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)dealloc
{
    [_menuItems release];
    _menuItems = nil;
    [super dealloc];
}

@end
