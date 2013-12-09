//
//  WeiboGeo.m
//  HelloApplink
//
//  Created by Peter on 13-11-26.
//
//

#import "WeiboGeo.h"

@implementation WeiboGeo

@synthesize longitude;
@synthesize latitude;
@synthesize city;
@synthesize province;
@synthesize city_name;
@synthesize province_name;
@synthesize address;
@synthesize pinyin;
@synthesize more;

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc] init];
    [s appendString:[NSString stringWithFormat:@"longitude = %@\r\n",self.longitude]];
    [s appendString:[NSString stringWithFormat:@"latitude = %@\r\n",self.latitude]];
    [s appendString:[NSString stringWithFormat:@"city = %@\r\n",self.city]];
    [s appendString:[NSString stringWithFormat:@"province = %@\r\n",self.province]];
    [s appendString:[NSString stringWithFormat:@"city_name = %@\r\n",self.city_name]];
    [s appendString:[NSString stringWithFormat:@"province_name = %@\r\n",self.province_name]];
    [s appendString:[NSString stringWithFormat:@"address = %@\r\n",self.address]];
    [s appendString:[NSString stringWithFormat:@"pinyin = %@\r\n",self.pinyin]];
    [s appendString:[NSString stringWithFormat:@"more = %@\r\n",self.more]];
    return [s autorelease];
}

- (void)dealloc
{
    self.longitude = nil;
    self.latitude = nil;
    self.city = nil;
    self.province = nil;
    self.city_name = nil;
    self.province_name = nil;
    self.address = nil;
    self.pinyin = nil;
    self.more = nil;
    [super dealloc];
}

@end
