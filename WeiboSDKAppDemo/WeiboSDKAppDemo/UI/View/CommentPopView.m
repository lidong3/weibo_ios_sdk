//
//  CommentPopView.m
//  Main
//
//  Created by qxxw_a_n on 13-10-12.
//  Copyright (c) 2013年 liu peng. All rights reserved.
//

#import "CommentPopView.h"
#import "UICommonCategory.h"
#import "UIImage+Scaling.h"

@implementation CommentPopView

@synthesize blessTextView;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImageView = [UIImageView getImageWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) superView:self];
        _bgImageView.image = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bless_bg@2x" ofType:@"png"]] scaledImageStretchableImage];
        
//        _titleLabel = [UILabel getLabelWithFontSize:17.0 backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] superView:self];
//        _titleLabel.text = @"卡片祝福";
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.frame = CGRectMake(0, 4, frame.size.width, 21);
//        
//        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 31, frame.size.width, 1)];
//        _lineView.backgroundColor = [UIColor blackColor];
//        [self addSubview:_lineView];
//        [_lineView release];
        
        self.blessTextView = [[[UITextView alloc] initWithFrame:CGRectMake(0, 2, frame.size.width, 97)] autorelease];
        self.blessTextView.textColor = [UIColor blackColor];
        self.blessTextView.backgroundColor = [UIColor clearColor];
        self.blessTextView.delegate = self;
        self.blessTextView.returnKeyType=UIReturnKeyDone;
        self.blessTextView.text = @"写点评论吧 ～";
        self.blessTextView.font = [UIFont systemFontOfSize:17.0];
        [self addSubview:self.blessTextView];
        
        _limitLabel = [UILabel getLabelWithFontSize:14.0 backgroundColor:[UIColor clearColor] textColor:[UIColor lightGrayColor] superView:self];
        _limitLabel.textAlignment = NSTextAlignmentRight;
        _limitLabel.frame = CGRectMake(0, 101, frame.size.width - 2, 18);
        
        _leftBtn = [UIButton getStretchButtonNormalImage:@"toast_button_up" hightImageName:@"toast_button_down" selector:@selector(leftClick) target:self supview:self];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        _leftBtn.frame = CGRectMake(10, frame.size.height - 49, frame.size.width/2.0 - 15, 44);
        
        _rightBtn = [UIButton getStretchButtonNormalImage:@"toast_button_up" hightImageName:@"toast_button_down" selector:@selector(rightClick) target:self supview:self];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _rightBtn.frame = CGRectMake(frame.size.width/2.0 + 5, frame.size.height - 49, frame.size.width/2.0 - 15, 44);
        
    }
    return self;
}

- (void)leftClick
{
    self.blessTextView.text = @"写点评论吧 ～";
    if (_delegate && [_delegate respondsToSelector:@selector(blessCardLeftEvent)]) {
        [_delegate blessCardLeftEvent];
    }
}

- (void)rightClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(blessCardRightEvent:)]) {
        [_delegate blessCardRightEvent:blessTextView.text];
    }
}

- (void)dealloc
{
    [self setBlessTextView:nil];
    [super dealloc];
}

#pragma mark -UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.blessTextView.text isEqualToString:@"写点评论吧 ～"]) {
        blessTextView.text = @"";
    }
    _limitLabel.text = [NSString stringWithFormat:@"%ld字",(long)140 - [textView.text length]];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length > 140) {
        textView.text = [textView.text substringToIndex:140];
    }else if (textView.text.length == 0){
        textView.text = @"写点评论吧 ～";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    NSString *str = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if(str.length > 140){
        return NO;
    }
    _limitLabel.text = [NSString stringWithFormat:@"%ld字",(long)140 - [str length]];
    return YES;
}

@end
