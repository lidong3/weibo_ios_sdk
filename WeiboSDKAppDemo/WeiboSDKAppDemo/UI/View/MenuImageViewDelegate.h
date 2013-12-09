//
//  MenuImageViewDelegate.h
//  RCS
//
//  Created by qxxw_a_n on 13-9-23.
//  Copyright (c) 2013年 feinno. All rights reserved.
//

#define TransmitID @"转发"
#define CommentID  @"评论"
#define CollectID  @"收藏"
#define ShowJsonID @"显示具体数据"
#define DeleteID   @"删除"

@protocol MenuImageViewDelegate <NSObject>

@optional
- (void)OnTransmitCallback;
- (void)OnCommentCallback;
- (void)OnCollectCallback;
- (void)OnJsonCallback;
- (void)OnDeleteCallback;
@end
