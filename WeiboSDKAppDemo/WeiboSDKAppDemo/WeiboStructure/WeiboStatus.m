//
//  WeiboStatus.m
//  HelloApplink
//
//  Created by Peter on 13-11-26.
//
//

#import "WeiboStatus.h"

@implementation WeiboStatus

@synthesize created_at;
@synthesize Id;
@synthesize mid;
@synthesize idstr;
@synthesize text;
@synthesize source;
@synthesize favorited;
@synthesize truncated;
@synthesize in_reply_to_status_id;
@synthesize in_reply_to_user_id;
@synthesize in_reply_to_screen_name;
@synthesize thumbnail_pic;
@synthesize bmiddle_pic;
@synthesize geo;
@synthesize user;
@synthesize retweeted_status;
@synthesize reposts_count;
@synthesize comments_count;
@synthesize attitudes_count;
@synthesize mlevel;
@synthesize pic_urls;
@synthesize object_array;

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc] init];
    [s appendString:[NSString stringWithFormat:@"created_at = %@\r\n",self.created_at]];
    [s appendString:[NSString stringWithFormat:@"Id = %lld\r\n",self.Id]];
    [s appendString:[NSString stringWithFormat:@"mid = %lld\r\n",self.mid]];
    [s appendString:[NSString stringWithFormat:@"idstr = %@\r\n",self.idstr]];
    [s appendString:[NSString stringWithFormat:@"text = %@\r\n",self.text]];
    [s appendString:[NSString stringWithFormat:@"source = %@\r\n",self.source]];
    [s appendString:[NSString stringWithFormat:@"favorited = %d\r\n",self.favorited]];
    [s appendString:[NSString stringWithFormat:@"truncated = %d\r\n",self.truncated]];
    [s appendString:[NSString stringWithFormat:@"in_reply_to_status_id = %@\r\n",self.in_reply_to_status_id]];
    [s appendString:[NSString stringWithFormat:@"in_reply_to_user_id = %@\r\n",self.in_reply_to_user_id]];
    [s appendString:[NSString stringWithFormat:@"in_reply_to_screen_name = %@\r\n",self.in_reply_to_screen_name]];
    [s appendString:[NSString stringWithFormat:@"thumbnail_pic = %@\r\n",self.thumbnail_pic]];
    [s appendString:[NSString stringWithFormat:@"bmiddle_pic = %@\r\n",self.bmiddle_pic]];
    [s appendString:[NSString stringWithFormat:@"original_pic = %@\r\n",self.original_pic]];
    [s appendString:[NSString stringWithFormat:@"geo = \r{%@}\r\n",self.geo]];
    [s appendString:[NSString stringWithFormat:@"user = \r{%@}\r\n",self.user]];
    [s appendString:[NSString stringWithFormat:@"retweeted_status = \r{%@}\r\n",self.retweeted_status]];
    [s appendString:[NSString stringWithFormat:@"reposts_count = %d\r\n",self.reposts_count]];
    [s appendString:[NSString stringWithFormat:@"comments_count = %d\r\n",self.comments_count]];
    [s appendString:[NSString stringWithFormat:@"attitudes_count = %d\r\n",self.attitudes_count]];
    [s appendString:[NSString stringWithFormat:@"mlevel = %d\r\n",self.mlevel]];
    [s appendString:[NSString stringWithFormat:@"pic_urls = %@\r\n",self.pic_urls]];
    [s appendString:[NSString stringWithFormat:@"object_array = %@\r\n",self.object_array]];
    return [s autorelease];
}

- (void)dealloc
{
    self.created_at = nil;
    self.idstr = nil;
    self.text = nil;
    self.source = nil;
    self.in_reply_to_status_id = nil;
    self.in_reply_to_user_id = nil;
    self.in_reply_to_screen_name = nil;
    self.thumbnail_pic = nil;
    self.bmiddle_pic = nil;
    self.original_pic = nil;
    self.geo = nil;
    self.user = nil;
    self.retweeted_status = nil;
    self.pic_urls = nil;
    self.object_array = nil;
    [super dealloc];
}

@end
