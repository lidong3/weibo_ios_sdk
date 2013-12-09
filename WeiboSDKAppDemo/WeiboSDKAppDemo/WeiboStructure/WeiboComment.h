//
//  WeiboComment.h
//  HelloApplink
//
//  Created by Peter on 13-11-26.
//
//

#import <Foundation/Foundation.h>

@class WeiboUser;
@class WeiboStatus;

@interface WeiboComment : NSObject

//评论创建时间
@property (nonatomic, copy)NSString *created_at;
//评论的ID
@property (nonatomic, assign)long long Id;
//评论的内容
@property (nonatomic, copy)NSString *text;
//评论的来源
@property (nonatomic, copy)NSString *source;
//评论作者的用户信息字段
@property (nonatomic, retain)WeiboUser *user;
//评论的MID
@property (nonatomic, copy)NSString *mid;
//字符串型的评论ID
@property (nonatomic, copy)NSString *idstr;
//评论的微博信息字段
@property (nonatomic, retain)WeiboStatus *status;
//评论来源评论，当本评论属于对另一评论的回复时返回此字段
@property (nonatomic, retain)WeiboComment *reply_comment;

@end
