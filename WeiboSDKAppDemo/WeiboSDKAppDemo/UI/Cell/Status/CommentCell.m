//
//  CommentCell.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-5.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "CommentCell.h"
#import "FileManager.h"
#import "CellHelp.h"
#import "WeiboUser.h"

@implementation CommentCell

@synthesize comment;
@synthesize delegate;

+ (CGFloat)getCommnetCellHeightWithText:(WeiboComment *)comment
{
    CGFloat ret = 0;
    CGSize textSize = [comment.text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(MaxTextWidth, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
    if (textSize.height > MaxTextHeight) {
        ret = MaxTextHeight + 5;
    }else if (textSize.height < MinTextHeight){
        ret = MinTextHeight + 5;
    }else{
        ret = textSize.height + 5;
    }
    return ret;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _portraitBtn = [UIButton getButtonNormalImage:nil hightImageName:nil selector:@selector(portraitClick) target:self supview:self.contentView];
        _portraitBtn.frame = CGRectMake(5, 10, PortraitSize, PortraitSize);
        
        _userNameLabel = [UILabel getLabelWithFontSize:14.0 backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] superView:self.contentView];
        _userNameLabel.frame = CGRectMake(PortraitSize + 20, 10 , 250, 18);
        
        _statusTextLabel = [UILabel getLabelWithFontSize:14.0 backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] superView:self.contentView];
        _statusTextLabel.textAlignment = UITextAlignmentLeft;
        _statusTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _statusTextLabel.numberOfLines = 100;
    }
    return self;
}

- (void)portraitClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnPortraitClick:)]) {
        [self.delegate OnPortraitClick:self.comment];
    }
}

- (void)refrushUIWithPortrait:(NSString *)protraitPath
{
    if ([FileManager isExist:protraitPath]) {
        [_portraitBtn setBackgroundImage:[UIImage imageWithContentsOfFile:protraitPath] forState:UIControlStateNormal];
    }else{
        [_portraitBtn setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
    }
}

- (void)refrushUIWithComment
{
    CGFloat statusTextHeight = 0;
    CGSize textSize = [comment.text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(MaxTextWidth, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
    if (textSize.height > MaxTextHeight) {
        statusTextHeight = MaxTextHeight;
    }else if (textSize.height < MinTextHeight){
        statusTextHeight = MinTextHeight;
    }else{
        statusTextHeight = textSize.height;
    }
    _statusTextLabel.frame = CGRectMake(70, _userNameLabel.frame.size.height + _userNameLabel.frame.origin.y + 5, 200, statusTextHeight);
    _statusTextLabel.text = self.comment.text;
}

- (void)refrushUIWithUser
{
    _userNameLabel.text = self.comment.user.screen_name ? self.comment.user.screen_name : self.comment.user.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
