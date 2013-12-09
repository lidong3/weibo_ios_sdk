//
//  WeiboPrivacy.m
//  HelloApplink
//
//  Created by Peter on 13-11-26.
//
//

#import "WeiboPrivacy.h"

@implementation WeiboPrivacy

@synthesize comment;
@synthesize geo;
@synthesize message;
@synthesize realname;
@synthesize badge;
@synthesize mobile;
@synthesize webim;

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc] init];
    [s appendString:[NSString stringWithFormat:@"comment = %d\r\n",self.comment]];
    [s appendString:[NSString stringWithFormat:@"geo = %d\r\n",self.geo]];
    [s appendString:[NSString stringWithFormat:@"message = %d\r\n",self.message]];
    [s appendString:[NSString stringWithFormat:@"realname = %d\r\n",self.realname]];
    [s appendString:[NSString stringWithFormat:@"badge = %d\r\n",self.badge]];
    [s appendString:[NSString stringWithFormat:@"mobile = %d\r\n",self.mobile]];
    [s appendString:[NSString stringWithFormat:@"webim = %d\r\n",self.webim]];
    return [s autorelease];
}

@end
