//
//  WeiboRemind.h
//  HelloApplink
//
//  Created by Peter on 13-11-26.
//
//

#import <Foundation/Foundation.h>

@interface WeiboRemind : NSObject

//新微博未读数
@property (nonatomic, assign)int status;
//新粉丝数
@property (nonatomic, assign)int follower;
//新评论数
@property (nonatomic, assign)int cmt;
//新私信数
@property (nonatomic, assign)int dm;
//新提及我的微博数
@property (nonatomic, assign)int mention_status;
//新提及我的评论数
@property (nonatomic, assign)int mention_cmt;
//微群消息未读数
@property (nonatomic, assign)int group;
//私有微群消息未读数
@property (nonatomic, assign)int private_group;
//新通知未读数
@property (nonatomic, assign)int notice;
//新邀请未读数
@property (nonatomic, assign)int invite;
//新勋章数
@property (nonatomic, assign)int badge;
//相册消息未读数
@property (nonatomic, assign)int photo;
//{{{3}}}
@property (nonatomic, assign)int msgbox;

@end
