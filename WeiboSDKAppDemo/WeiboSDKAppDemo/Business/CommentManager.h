//
//  CommentManager.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-5.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "BaseManager.h"

@class WeiboComment;

@protocol CommentManagerDelegate <NSObject>
@optional

- (void)OnGetCommentListSuc:(NSArray *)list;

- (void)OnCommentCreateSuc;

- (void)OnCommentFailed:(NSString *)errorMsg;

@end

@interface CommentManager : BaseManager

@property (nonatomic, assign)id <CommentManagerDelegate> delegate;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(CommentManager);

//根据微博ID返回某条微博的评论列表
- (void)getCommentListWithStatusId:(long long)Id
                             count:(int)count
                          delegate:(id <CommentManagerDelegate>)theDelegate;

//评论微博
//参考文档 http://open.weibo.com/wiki/2/comments/create
- (void)commentCreateWithComment:(NSString *)comment
                        statusId:(long long)statusId
                     comment_ori:(int)ori
                        delegate:(id <CommentManagerDelegate>)theDelegate;

@end
