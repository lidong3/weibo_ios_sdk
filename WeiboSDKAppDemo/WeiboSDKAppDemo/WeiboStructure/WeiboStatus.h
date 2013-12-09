//
//  WeiboStatus.h
//  HelloApplink
//
//  Created by Peter on 13-11-26.
//
//

#import <Foundation/Foundation.h>

@class WeiboGeo;
@class WeiboUser;

@interface WeiboStatus : NSObject

//微博创建时间
@property (nonatomic, copy)NSString *created_at;
//微博ID
@property (nonatomic, assign)long long Id;
//微博MID
@property (nonatomic, assign)long long mid;
//字符串型的微博ID
@property (nonatomic, copy)NSString *idstr;
//微博信息内容
@property (nonatomic, copy)NSString *text;
//微博来源
@property (nonatomic, copy)NSString *source;
//是否已收藏
@property (nonatomic, assign)BOOL favorited;
//是否已被截断
@property (nonatomic, assign)BOOL truncated;
//（暂未支持）回复ID
@property (nonatomic, copy)NSString *in_reply_to_status_id;
//（暂未支持）回复人UID
@property (nonatomic, copy)NSString *in_reply_to_user_id;
//（暂未支持）回复人昵称
@property (nonatomic, copy)NSString *in_reply_to_screen_name;
//缩略图片地址，没有时不返回此字段
@property (nonatomic, copy)NSString *thumbnail_pic;
//中等尺寸图片地址，没有时不返回此字段
@property (nonatomic, copy)NSString *bmiddle_pic;
//原始图片地址，没有时不返回此字段
@property (nonatomic, copy)NSString *original_pic;
//地理信息字段
@property (nonatomic, retain)WeiboGeo *geo;
//微博作者的用户信息字段
@property (nonatomic, retain)WeiboUser *user;
//被转发的原微博信息字段，当该微博为转发微博时返回
@property (nonatomic, retain)WeiboStatus *retweeted_status;
//转发数
@property (nonatomic, assign)int reposts_count;
//评论数
@property (nonatomic, assign)int comments_count;
//表态数
@property (nonatomic, assign)int attitudes_count;
//暂未支持
@property (nonatomic, assign)int mlevel;

//visible
//微博配图地址。多图时返回多图链接。无配图返回“[]”
@property (nonatomic, retain)NSArray *pic_urls;
//ad
@property (nonatomic, retain)NSArray *object_array;

- (NSString *)description;

@end
