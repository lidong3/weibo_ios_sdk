//
//  WeiboStructureParser.m
//  HelloApplink
//
//  Created by Peter on 13-11-26.
//
//

#import "WeiboStructureParser.h"
#import "WeiboStatus.h"
#import "WeiboGeo.h"
#import "WeiboComment.h"
#import "WeiboPrivacy.h"
#import "WeiboRemind.h"
#import "WeiboUser.h"

@implementation WeiboStructureParser

+ (BOOL)availableParam:(id)param
{
    BOOL ret = YES;
    if (param == nil) {
        ret = NO;
    }else if ([param isKindOfClass:[NSString class]]){
        ret = NO;
    }else if ([param isKindOfClass:[NSNull class]]){
        ret = NO;
    }
    return ret;
}

+ (WeiboStatus *)statusParserByParam:(NSDictionary *)param
{
    if (![WeiboStructureParser availableParam:param]) {
        return nil;
    }
    WeiboStatus *status = [[WeiboStatus alloc] init];
    status.created_at = [param objectForKey:@"created_at"];
    status.Id = [[param objectForKey:@"id"] longLongValue];
    status.mid = [[param objectForKey:@"mid"] longLongValue];
    status.idstr = [param objectForKey:@"idstr"];
    status.text = [param objectForKey:@"text"];
    status.source = [param objectForKey:@"source"];
    status.favorited = [[param objectForKey:@"favorited"] boolValue];
    status.truncated = [[param objectForKey:@"truncated"] boolValue];
    status.in_reply_to_status_id = [param objectForKey:@"in_reply_to_status_id"];
    status.in_reply_to_user_id = [param objectForKey:@"in_reply_to_user_id"];
    status.in_reply_to_screen_name = [param objectForKey:@"in_reply_to_screen_name"];
    status.thumbnail_pic = [param objectForKey:@"thumbnail_pic"];
    status.bmiddle_pic = [param objectForKey:@"bmiddle_pic"];
    status.original_pic = [param objectForKey:@"original_pic"];
    status.geo = [WeiboStructureParser geoParserByParam:[param objectForKey:@"geo"]];
    status.user = [WeiboStructureParser userParserByParam:[param objectForKey:@"user"]];
    status.retweeted_status = [WeiboStructureParser statusParserByParam:[param objectForKey:@"retweeted_status"]];
    status.reposts_count = [[param objectForKey:@"reposts_count"] intValue];
    status.comments_count = [[param objectForKey:@"comments_count"] intValue];
    status.attitudes_count = [[param objectForKey:@"attitudes_count"] intValue];
    status.mlevel = [[param objectForKey:@"mlevel"] intValue];
    status.pic_urls = [param objectForKey:@"pic_urls"];
    status.object_array = [param objectForKey:@"object_array"];
    return [status autorelease];
}

+ (WeiboGeo *)geoParserByParam:(NSDictionary *)param
{
    if (![WeiboStructureParser availableParam:param]) {
        return nil;
    }
    WeiboGeo *geo = [[WeiboGeo alloc] init];
    geo.longitude = [param objectForKey:@"longitude"];
    geo.latitude = [param objectForKey:@"latitude"];
    geo.city = [param objectForKey:@"city"];
    geo.province = [param objectForKey:@"province"];
    geo.city_name = [param objectForKey:@"city_name"];
    geo.province_name = [param objectForKey:@"province_name"];
    geo.address = [param objectForKey:@"address"];
    geo.pinyin = [param objectForKey:@"pinyin"];
    geo.more = [param objectForKey:@"more"];
    return [geo autorelease];
}

+ (WeiboUser *)userParserByParam:(NSDictionary *)param
{
    if (![WeiboStructureParser availableParam:param]) {
        return nil;
    }
    WeiboUser *user = [[WeiboUser alloc] init];
    user.Id = [[param objectForKey:@"id"] longLongValue];
    user.idstr = [param objectForKey:@"idstr"];
    user.screen_name = [param objectForKey:@"screen_name"];
    user.name = [param objectForKey:@"name"];
    user.province = [param objectForKey:@"province"];
    user.city = [param objectForKey:@"city"];
    user.userDescription = [param objectForKey:@"description"];
    user.url = [param objectForKey:@"url"];
    user.profile_image_url = [param objectForKey:@"profile_image_url"];
    user.profile_url = [param objectForKey:@"profile_url"];
    user.domain = [param objectForKey:@"domain"];
    user.profile_url = [param objectForKey:@"weihao"];
    user.domain = [param objectForKey:@"gender"];
    user.followers_count = [[param objectForKey:@"followers_count"] intValue];
    user.friends_count = [[param objectForKey:@"friends_count"] intValue];
    user.statuses_count = [[param objectForKey:@"statuses_count"] intValue];
    user.favourites_count = [[param objectForKey:@"favourites_count"] intValue];
    user.created_at = [param objectForKey:@"created_at"];
    user.following = [[param objectForKey:@"following"] boolValue];
    user.allow_all_act_msg = [[param objectForKey:@"allow_all_act_msg"] boolValue];
    user.geo_enabled = [[param objectForKey:@"geo_enabled"] boolValue];
    user.verified = [[param objectForKey:@"verified"] boolValue];
    user.verified_type = [[param objectForKey:@"verified_type"] intValue];
    user.remark = [param objectForKey:@"remark"];
    user.status = [WeiboStructureParser statusParserByParam:[param objectForKey:@"status"]];
    user.allow_all_comment = [[param objectForKey:@"allow_all_comment"] boolValue];
    user.avatar_large = [param objectForKey:@"avatar_large"];
    user.avatar_hd = [param objectForKey:@"avatar_hd"];
    user.verified_reason = [param objectForKey:@"verified_reason"];
    user.follow_me = [[param objectForKey:@"follow_me"] boolValue];
    user.online_status = [[param objectForKey:@"online_status"] intValue];
    user.bi_followers_count = [[param objectForKey:@"bi_followers_count"] intValue];
    user.lang = [param objectForKey:@"lang"];
    return [user autorelease];
}

+ (WeiboComment *)commentParserByParam:(NSDictionary *)param
{
    if (![WeiboStructureParser availableParam:param]) {
        return nil;
    }
    WeiboComment *comment = [[WeiboComment alloc] init];
    comment.created_at = [param objectForKey:@"created_at"];
    comment.Id = [[param objectForKey:@"id"] longLongValue];
    comment.text = [param objectForKey:@"text"];
    comment.source = [param objectForKey:@"source"];
    comment.user = [WeiboStructureParser userParserByParam:[param objectForKey:@"user"]];
    comment.mid = [param objectForKey:@"mid"];
    comment.idstr = [param objectForKey:@"idstr"];
    comment.status = [WeiboStructureParser statusParserByParam:[param objectForKey:@"status"]];
    comment.reply_comment = [WeiboStructureParser commentParserByParam:[param objectForKey:@"reply_comment"]];
    return [comment autorelease];
}

+ (WeiboPrivacy *)privacyParserByParam:(NSDictionary *)param
{
    if (![WeiboStructureParser availableParam:param]) {
        return nil;
    }
    WeiboPrivacy *privacy = [[WeiboPrivacy alloc] init];
    privacy.comment = [[param objectForKey:@"comment"] intValue];
    privacy.geo = [[param objectForKey:@"geo"] intValue];
    privacy.message = [[param objectForKey:@"message"] intValue];
    privacy.realname = [[param objectForKey:@"realname"] intValue];
    privacy.badge = [[param objectForKey:@"badge"] intValue];
    privacy.mobile = [[param objectForKey:@"mobile"] intValue];
    privacy.webim = [[param objectForKey:@"webim"] intValue];
    return [privacy autorelease];
}

+ (WeiboRemind *)remindParserByParam:(NSDictionary *)param
{
    if (![WeiboStructureParser availableParam:param]) {
        return nil;
    }
    WeiboRemind *remind = [[WeiboRemind alloc] init];
    remind.status = [[param objectForKey:@"status"] intValue];
    remind.follower = [[param objectForKey:@"follower"] intValue];
    remind.cmt = [[param objectForKey:@"cmt"] intValue];
    remind.dm = [[param objectForKey:@"dm"] intValue];
    remind.mention_status = [[param objectForKey:@"mention_status"] intValue];
    remind.mention_cmt = [[param objectForKey:@"mention_cmt"] intValue];
    remind.group = [[param objectForKey:@"group"] intValue];
    remind.private_group = [[param objectForKey:@"private_group"] intValue];
    remind.notice = [[param objectForKey:@"notice"] intValue];
    remind.invite = [[param objectForKey:@"invite"] intValue];
    remind.badge = [[param objectForKey:@"badge"] intValue];
    remind.photo = [[param objectForKey:@"photo"] intValue];
    remind.msgbox = [[param objectForKey:@"msgbox"] intValue];
    return [remind autorelease];
}

@end
