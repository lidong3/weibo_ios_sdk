//
//  StatusCell.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-2.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UIBaseCell.h"
#import "MenuImageView.h"

@class WeiboUser;
@class WeiboStatus;

@protocol StatusCellDelegate <NSObject>
@optional
- (void)OnPortraitClick:(WeiboStatus *)status;
- (void)OnSourceClick:(WeiboStatus *)status;
- (void)OnTransmitCallback:(WeiboStatus *)status;
- (void)OnCommentCallback:(WeiboStatus *)status;
- (void)OnCollectCallback:(WeiboStatus *)status;
- (void)OnJsonCallback:(WeiboStatus *)status;
- (void)OnDeleteCallback:(WeiboStatus *)status;

@end

@interface StatusCell : UIBaseCell <MenuImageViewDelegate>
{
    MenuImageView *_menuImageView;
    UIButton *_portraitBtn;
    UILabel *_userNameLabel;
    UILabel *_statusTextLabel;
    UIButton *_sourceImageBtn;
}
@property (nonatomic, strong)WeiboStatus *status;
@property (nonatomic, assign)id <StatusCellDelegate> delegate;

+ (CGFloat)getStatusCellHeightWithText:(WeiboStatus *)status;

- (void)refrushUIWithUser;

- (void)refrushUIWithPortrait:(NSString *)protraitPath;

- (void)refrushUIWithStatus;

- (void)refrushUIWithSourceImage;

@end
