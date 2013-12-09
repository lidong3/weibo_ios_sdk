//
//  WeiboUser.m
//  HelloApplink
//
//  Created by Peter on 13-11-26.
//
//

#import "WeiboUser.h"

@implementation WeiboUser

@synthesize Id;
@synthesize idstr;
@synthesize screen_name;
@synthesize name;
@synthesize province;
@synthesize city;
@synthesize location;
@synthesize userDescription;
@synthesize url;
@synthesize profile_image_url;
@synthesize profile_url;
@synthesize domain;
@synthesize weihao;
@synthesize gender;
@synthesize followers_count;
@synthesize friends_count;
@synthesize statuses_count;
@synthesize favourites_count;
@synthesize created_at;
@synthesize following;
@synthesize allow_all_act_msg;
@synthesize geo_enabled;
@synthesize verified;
@synthesize verified_type;
@synthesize remark;
@synthesize status;
@synthesize allow_all_comment;
@synthesize avatar_large;
@synthesize avatar_hd;
@synthesize verified_reason;
@synthesize follow_me;
@synthesize online_status;
@synthesize bi_followers_count;
@synthesize lang;

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc] init];
    [s appendString:[NSString stringWithFormat:@"Id = %lld\r\n",self.Id]];
    [s appendString:[NSString stringWithFormat:@"idstr = %@\r\n",self.idstr]];
    [s appendString:[NSString stringWithFormat:@"screen_name = %@\r\n",self.screen_name]];
    [s appendString:[NSString stringWithFormat:@"name = %@\r\n",self.name]];
    [s appendString:[NSString stringWithFormat:@"province = %@\r\n",self.province]];
    [s appendString:[NSString stringWithFormat:@"city = %@\r\n",self.city]];
    [s appendString:[NSString stringWithFormat:@"location = %@\r\n",self.location]];
    [s appendString:[NSString stringWithFormat:@"description = %@\r\n",self.userDescription]];
    [s appendString:[NSString stringWithFormat:@"url = %@\r\n",self.url]];
    [s appendString:[NSString stringWithFormat:@"profile_image_url = %@\r\n",self.profile_image_url]];
    [s appendString:[NSString stringWithFormat:@"profile_url = %@\r\n",self.profile_url]];
    [s appendString:[NSString stringWithFormat:@"domain = %@\r\n",self.domain]];
    [s appendString:[NSString stringWithFormat:@"weihao = %@\r\n",self.weihao]];
    [s appendString:[NSString stringWithFormat:@"gender = %@\r\n",self.gender]];
    [s appendString:[NSString stringWithFormat:@"followers_count = %d\r\n",self.followers_count]];
    [s appendString:[NSString stringWithFormat:@"friends_count = %d\r\n",self.friends_count]];
    [s appendString:[NSString stringWithFormat:@"statuses_count = %d\r\n",self.statuses_count]];
    [s appendString:[NSString stringWithFormat:@"favourites_count = %d\r\n",self.favourites_count]];
    [s appendString:[NSString stringWithFormat:@"created_at = %@\r\n",self.created_at]];
    [s appendString:[NSString stringWithFormat:@"following = %d\r\n",self.following]];
    [s appendString:[NSString stringWithFormat:@"allow_all_act_msg = %d\r\n",self.allow_all_act_msg]];
    [s appendString:[NSString stringWithFormat:@"geo_enabled = %d\r\n",self.geo_enabled]];
    [s appendString:[NSString stringWithFormat:@"verified = %d\r\n",self.verified]];
    [s appendString:[NSString stringWithFormat:@"verified_type = %d\r\n",self.verified_type]];
    [s appendString:[NSString stringWithFormat:@"remark = %@\r\n",self.remark]];
    [s appendString:[NSString stringWithFormat:@"status = \r{%@}\r\n",self.status]];
    [s appendString:[NSString stringWithFormat:@"allow_all_comment = %d\r\n",self.allow_all_comment]];
    [s appendString:[NSString stringWithFormat:@"avatar_large = %@\r\n",self.avatar_large]];
    [s appendString:[NSString stringWithFormat:@"avatar_hd = %@\r\n",self.avatar_hd]];
    [s appendString:[NSString stringWithFormat:@"verified_reason = %@\r\n",self.verified_reason]];
    [s appendString:[NSString stringWithFormat:@"follow_me = %d\r\n",self.follow_me]];
    [s appendString:[NSString stringWithFormat:@"online_status = %d\r\n",self.online_status]];
    [s appendString:[NSString stringWithFormat:@"bi_followers_count = %d\r\n",self.bi_followers_count]];
    [s appendString:[NSString stringWithFormat:@"lang = %@\r\n",self.lang]];
    return [s autorelease];
}

- (void)dealloc
{
    self.idstr = nil;
    self.screen_name = nil;
    self.name = nil;
    self.province = nil;
    self.city = nil;
    self.location = nil;
    self.userDescription = nil;
    self.url = nil;
    self.profile_image_url = nil;
    self.profile_url = nil;
    self.domain = nil;
    self.weihao = nil;
    self.gender = nil;
    self.created_at = nil;
    self.remark = nil;
    self.status = nil;
    self.avatar_large = nil;
    self.avatar_hd = nil;
    self.verified_reason = nil;
    self.lang = nil;
    [super dealloc];
}


@end
