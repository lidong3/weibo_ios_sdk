//
//  WeiboRemind.m
//  HelloApplink
//
//  Created by Peter on 13-11-26.
//
//

#import "WeiboRemind.h"

@implementation WeiboRemind

@synthesize status;
@synthesize follower;
@synthesize cmt;
@synthesize dm;
@synthesize mention_status;
@synthesize mention_cmt;
@synthesize group;
@synthesize private_group;
@synthesize notice;
@synthesize invite;
@synthesize badge;
@synthesize photo;
@synthesize msgbox;

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc] init];
    [s appendString:[NSString stringWithFormat:@"status = %d\r\n",self.status]];
    [s appendString:[NSString stringWithFormat:@"follower = %d\r\n",self.follower]];
    [s appendString:[NSString stringWithFormat:@"cmt = %d\r\n",self.cmt]];
    [s appendString:[NSString stringWithFormat:@"dm = %d\r\n",self.dm]];
    [s appendString:[NSString stringWithFormat:@"mention_status = %d\r\n",self.mention_status]];
    [s appendString:[NSString stringWithFormat:@"mention_cmt = %d\r\n",self.mention_cmt]];
    [s appendString:[NSString stringWithFormat:@"group = %d\r\n",self.group]];
    [s appendString:[NSString stringWithFormat:@"private_group = %d\r\n",self.private_group]];
    [s appendString:[NSString stringWithFormat:@"notice = %d\r\n",self.notice]];
    [s appendString:[NSString stringWithFormat:@"invite = %d\r\n",self.invite]];
    [s appendString:[NSString stringWithFormat:@"badge = %d\r\n",self.badge]];
    [s appendString:[NSString stringWithFormat:@"photo = %d\r\n",self.photo]];
    [s appendString:[NSString stringWithFormat:@"msgbox = %d\r\n",self.msgbox]];
    return [s autorelease];
}

@end
