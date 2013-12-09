//
//  CommentCell.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-5.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UIBaseCell.h"
#import "WeiboComment.h"

@protocol CommentCellDelegate <NSObject>

@optional
- (void)OnPortraitClick:(WeiboComment *)comment;

@end

@interface CommentCell : UIBaseCell
{
    UIButton *_portraitBtn;
    UILabel *_userNameLabel;
    UILabel *_statusTextLabel;
}

@property (nonatomic, retain)WeiboComment *comment;
@property (nonatomic, assign)id <CommentCellDelegate> delegate;

+ (CGFloat)getCommnetCellHeightWithText:(WeiboComment *)comment;

- (void)refrushUIWithComment;
- (void)refrushUIWithPortrait:(NSString *)protraitPath;
- (void)refrushUIWithUser;
@end
