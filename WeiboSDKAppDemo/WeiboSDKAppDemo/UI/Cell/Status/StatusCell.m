//
//  StatusCell.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-2.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "StatusCell.h"
#import "CellHelp.h"
#import "WeiboStatus.h"
#import "WeiboUser.h"
#import "FileManager.h"
#import "StatusManager.h"

@implementation StatusCell

@synthesize delegate;

+ (CGFloat)getStatusCellHeightWithText:(WeiboStatus *)status
{
    CGFloat ret = 0;
    CGSize textSize = [status.text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(MaxTextWidth, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
    if (textSize.height > MaxTextHeight) {
        ret = MaxTextHeight + 5;
    }else if (textSize.height < MinTextHeight){
        ret = MinTextHeight + 5;
    }else{
        ret = textSize.height + 5;
    }
    CGFloat imageHeight = 0;
    if ([status.pic_urls count] > 0) {
        NSString *sourcePath = [[StatusManager sharedStatusManager] getThumbImageWithStatusId:status.Id];
        if ([FileManager isExist:sourcePath]) {
            UIImage *image = [UIImage imageWithContentsOfFile:sourcePath];
            ret += image.size.height + 5;
        }else{
            ret += DefaultImageHeight + 5;
        }
    }
    return ret + imageHeight;
}

@synthesize status;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _menuImageView = [[MenuImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEWIDTH, MinTextHeight)];
        [_menuImageView addMenuItemByID:TransmitID];
        [_menuImageView addMenuItemByID:ShowJsonID];
        [_menuImageView addMenuItemByID:DeleteID];
        _menuImageView.delegate = self;
        [_menuImageView setBackgroundColor:[UIColor clearColor]];
        _menuImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_menuImageView];
        
        _portraitBtn = [UIButton getButtonNormalImage:nil hightImageName:nil selector:@selector(portraitClick) target:self supview:self.contentView];
        _portraitBtn.frame = CGRectMake(5, 10, PortraitSize, PortraitSize);
        
        _userNameLabel = [UILabel getLabelWithFontSize:14.0 backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] superView:self.contentView];
        _userNameLabel.frame = CGRectMake(PortraitSize + 20, 10 , 250, 18);
        
        _statusTextLabel = [UILabel getLabelWithFontSize:14.0 backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] superView:self.contentView];
        _statusTextLabel.textAlignment = UITextAlignmentLeft;
        _statusTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _statusTextLabel.numberOfLines = 100;
        
        _sourceImageBtn = [UIButton getButtonNormalImage:nil hightImageName:nil selector:@selector(sourceClick) target:self supview:self.contentView];
        [_sourceImageBtn setBackgroundColor:[UIColor lightGrayColor]];
        
    }
    return self;
}

- (void)refrushUIWithUser
{
    _userNameLabel.text = self.status.user.screen_name ? self.status.user.screen_name : self.status.user.name;
}

- (void)refrushUIWithPortrait:(NSString *)protraitPath
{
    if ([FileManager isExist:protraitPath]) {
        [_portraitBtn setBackgroundImage:[UIImage imageWithContentsOfFile:protraitPath] forState:UIControlStateNormal];
    }else{
        [_portraitBtn setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
    }
}

- (void)refrushUIWithSourceImage
{
    NSString *sourcePath = [[StatusManager sharedStatusManager] getThumbImageWithStatusId:self.status.Id];
    if ([self.status.pic_urls count] > 0) {
        _sourceImageBtn.hidden = NO;
        if ([FileManager isExist:sourcePath]) {
            UIImage *image = [UIImage imageWithContentsOfFile:sourcePath];
            [_sourceImageBtn setBackgroundImage:image forState:UIControlStateNormal];
            _sourceImageBtn.frame = CGRectMake(_statusTextLabel.frame.origin.x, _statusTextLabel.frame.origin.y + _statusTextLabel.frame.size.height + 5, image.size.width, image.size.height);
        }else{
            [_sourceImageBtn setBackgroundImage:nil forState:UIControlStateNormal];
            _sourceImageBtn.frame = CGRectMake(_statusTextLabel.frame.origin.x, _statusTextLabel.frame.origin.y + _statusTextLabel.frame.size.height + 5, DefaultImageWidth, DefaultImageHeight);
        }
        _menuImageView.frame = CGRectMake(0, 0, SCREEHEIGHT, _sourceImageBtn.frame.origin.y + _sourceImageBtn.frame.size.height + 2 * CellSpace);
    }else{
        _menuImageView.frame = CGRectMake(0, 0, SCREEHEIGHT, _statusTextLabel.frame.origin.y + _statusTextLabel.frame.size.height + 2 * CellSpace);
        _sourceImageBtn.hidden = YES;
    }
    
}

- (void)refrushUIWithStatus
{
    CGFloat statusTextHeight = 0;
    CGSize textSize = [status.text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(MaxTextWidth, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
    if (textSize.height > MaxTextHeight) {
        statusTextHeight = MaxTextHeight;
    }else if (textSize.height < MinTextHeight){
        statusTextHeight = MinTextHeight;
    }else{
        statusTextHeight = textSize.height;
    }
    _menuImageView.frame = CGRectMake(0, 0, SCREEWIDTH, statusTextHeight + 2 * CellSpace);
    _statusTextLabel.frame = CGRectMake(70, _userNameLabel.frame.size.height + _userNameLabel.frame.origin.y + 5, 200, statusTextHeight);
    _statusTextLabel.text = self.status.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)portraitClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnPortraitClick:)]) {
        [self.delegate OnPortraitClick:self.status];
    }
}

- (void)sourceClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnSourceClick:)]) {
        [self.delegate OnSourceClick:self.status];
    }
}

#pragma mark -MenuImageViewDelegate
- (void)OnTransmitCallback
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnTransmitCallback:)]) {
        [self.delegate OnTransmitCallback:self.status];
    }
}

- (void)OnCommentCallback
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnCommentCallback:)]) {
        [self.delegate OnCommentCallback:self.status];
    }
}

- (void)OnCollectCallback
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnCollectCallback:)]) {
        [self.delegate OnCollectCallback:self.status];
    }
}

- (void)OnJsonCallback
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnJsonCallback:)]) {
        [self.delegate OnJsonCallback:self.status];
    }
}

- (void)OnDeleteCallback
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnDeleteCallback:)]) {
        [self.delegate OnDeleteCallback:self.status];
    }
}

@end
