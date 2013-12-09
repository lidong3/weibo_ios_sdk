//
//  CustomNavigationBar.m
//  Main
//
//  Created by qxxw_a_n on 13-9-16.
//  Copyright (c) 2013年 liu peng. All rights reserved.
//

#import "CustomNavigationBar.h"
#import "UICommonCategory.h"
#import "UIDeviceCommon.h"

@implementation CustomNavigationBar

@synthesize leftBtn = _leftBtn;
@synthesize rightBtn = _rightBtn;
@synthesize title = _title;
@synthesize bgImage = _bgImage;
@synthesize titleView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgImageView = [UIImageView getImageWithFrame:self.bounds superView:self];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        [_lineView setBackgroundColor:[UIColor whiteColor]];
        _lineView.alpha = 0.5;
        [self addSubview:_lineView];
        [_lineView release];
        if ([UIDeviceCommon isIOS7]) {
            self.titleView = [[[UIView alloc] initWithFrame:CGRectMake(50, 20, 220, frame.size.height - 20)] autorelease];
        }else{
            self.titleView = [[[UIView alloc] initWithFrame:CGRectMake(50, 0, 220, frame.size.height)] autorelease];
        }
        
        self.titleView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleView];
    }
    return self;
}

- (void)HasUnderLine:(BOOL)has
{
    if (has) {
        _lineView.hidden = NO;
    }else{
        _lineView.hidden = YES;
    }
}

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        if (_title) {
            [_title release];
            _title = nil;
        }
        _title = [title copy];
        if (_titleLabel == nil) {
            _titleLabel = [UILabel getLabelWithFontSize:20 backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] superView:self.titleView];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.frame = CGRectMake(0, 5, self.titleView.frame.size.width, 34);
        }
        _titleLabel.text = _title;
    }
}

- (void)setLeftBtn:(UIButton *)theLeftBtn
{
    if (_leftBtn != theLeftBtn) {
        if (_leftBtn) {
            [_leftBtn removeFromSuperview];
            _leftBtn = nil;
        }
        _leftBtn = theLeftBtn;
        [self addSubview:_leftBtn];
    }
}

- (void)setRightBtn:(UIButton *)theRightBtn
{
    if (_rightBtn != theRightBtn) {
        if (_rightBtn) {
            [_rightBtn removeFromSuperview];
            _rightBtn = nil;
        }
        _rightBtn = theRightBtn;
        [self addSubview:_rightBtn];
    }
}

- (void)setBgImage:(UIImage *)thgBgImage
{
    if (_bgImage != thgBgImage) {
        if (_bgImage) {
            [_bgImage release];
            _bgImage = nil;
        }
        _bgImage = [thgBgImage retain];
        _bgImageView.image = _bgImage;
    }
}

- (void)dealloc
{
    [_title release];
    _title = nil;
    self.titleView = nil;
    [super dealloc];
}

@end
