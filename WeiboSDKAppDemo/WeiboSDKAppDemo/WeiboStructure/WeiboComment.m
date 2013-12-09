//
//  WeiboComment.m
//  HelloApplink
//
//  Created by Peter on 13-11-26.
//
//

#import "WeiboComment.h"

@implementation WeiboComment

@synthesize created_at;
@synthesize Id;
@synthesize text;
@synthesize source;
@synthesize user;
@synthesize mid;
@synthesize idstr;
@synthesize status;
@synthesize reply_comment;

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc] init];
    [s appendString:[NSString stringWithFormat:@"created_at = %@\r\n",self.created_at]];
    [s appendString:[NSString stringWithFormat:@"Id = %lld\r\n",self.Id]];
    [s appendString:[NSString stringWithFormat:@"text = %@\r\n",self.text]];
    [s appendString:[NSString stringWithFormat:@"source = %@\r\n",self.source]];
    [s appendString:[NSString stringWithFormat:@"user = %@\r\n",self.user]];
    [s appendString:[NSString stringWithFormat:@"mid = %@\r\n",self.mid]];
    [s appendString:[NSString stringWithFormat:@"idstr = %@\r\n",self.idstr]];
    [s appendString:[NSString stringWithFormat:@"status = \r{%@}\r\n",self.status]];
    [s appendString:[NSString stringWithFormat:@"reply_comment = %@\r\n",self.reply_comment]];
    return [s autorelease];
}

- (void)dealloc
{
    self.created_at = nil;
    self.text = nil;
    self.source = nil;
    self.mid = nil;
    self.idstr = nil;
    self.user = nil;
    self.status = nil;
    self.reply_comment = nil;
    [super dealloc];
}

@end
