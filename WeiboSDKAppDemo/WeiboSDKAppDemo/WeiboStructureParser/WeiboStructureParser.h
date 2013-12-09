//
//  WeiboStructureParser.h
//  HelloApplink
//
//  Created by Peter on 13-11-26.
//
//

#import <Foundation/Foundation.h>

@class WeiboStatus;
@class WeiboGeo;
@class WeiboUser;
@class WeiboComment;
@class WeiboPrivacy;
@class WeiboRemind;

@interface WeiboStructureParser : NSObject

+ (WeiboStatus *)statusParserByParam:(NSDictionary *)param;
+ (WeiboGeo *)geoParserByParam:(NSDictionary *)param;
+ (WeiboUser *)userParserByParam:(NSDictionary *)param;
+ (WeiboComment *)commentParserByParam:(NSDictionary *)param;
+ (WeiboPrivacy *)privacyParserByParam:(NSDictionary *)param;
+ (WeiboRemind *)remindParserByParam:(NSDictionary *)param;


@end
