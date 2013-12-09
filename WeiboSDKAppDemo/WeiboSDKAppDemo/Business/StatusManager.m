//
//  StatusManager.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-11-29.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "StatusManager.h"
#import "RegisterManager.h"
#import "FileManager.h"
#import "WeiboStatus.h"

#define StatusPublicTimeLineUrl @"https://api.weibo.com/2/statuses/public_timeline.json"
#define StatusUpdateUrl         @"https://api.weibo.com/2/statuses/update.json"
#define StatusUplaodUrl         @"https://upload.api.weibo.com/2/statuses/upload.json"
#define StatusHomeTimeLineUrl   @"https://api.weibo.com/2/statuses/home_timeline.json"
#define StatusUserTimeLineUrl   @"https://api.weibo.com/2/statuses/user_timeline.json"
#define DeleteStatusUrl         @"https://api.weibo.com/2/statuses/destroy.json"
#define RepostStatusUrl         @"https://api.weibo.com/2/statuses/repost.json"

@implementation StatusManager

@synthesize delegate;

SYNTHESIZE_SINGLETON_FOR_CLASS(StatusManager);

- (id)init
{
    self = [super init];
    if (self) {
        _mapDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)registeDelegate:(id)theDelegate
{
    self.delegate = theDelegate;
}

- (void)unRegisteDelegate
{
    self.delegate = nil;
}

- (void)getStatusPublicTimeLineWithCount:(int)count
                                delegate:(id <StatusManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",count],@"count",nil];
    [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:StatusPublicTimeLineUrl httpMethod:@"GET" params:param delegate:self withTag:StatusPublicTimeLineUrl];
}

- (void)getStatusHomeTimeLineWithCount:(int)count
                              delegate:(id <StatusManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",count],@"count",nil];
    [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:StatusHomeTimeLineUrl httpMethod:@"GET" params:param delegate:self withTag:StatusHomeTimeLineUrl];
}

- (void)getStatusUserTimeLineWithCount:(int)count
                                userId:(long long)userId
                              delegate:(id <StatusManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",count],@"count",[NSString stringWithFormat:@"%lld",userId],@"uid",nil];
    [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:StatusUserTimeLineUrl httpMethod:@"GET" params:param delegate:self withTag:StatusUserTimeLineUrl];
}

- (void)statusesUpdate:(NSString *)text
               visible:(int)visible
                listId:(NSString *)listId
              latitude:(float)latitude
             longitude:(float)longitude
           annotations:(NSString *)annotations
              delegate:(id <StatusManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    NSString *utf8Str = [NSString stringWithCString:[text UTF8String] encoding:NSUTF8StringEncoding];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:6];
    if (utf8Str) {
        [params setObject:utf8Str forKey:@"status"];
    }
    if (listId) {
        [params setObject:listId forKey:@"list_id"];
    }
    if (latitude != 0) {
        [params setObject:[NSString stringWithFormat:@"%f",latitude] forKey:@"lat"];
    }
    if (longitude != 0) {
        [params setObject:[NSString stringWithFormat:@"%f",longitude] forKey:@"long"];
    }
    [params setObject:[NSString stringWithFormat:@"%d",visible] forKey:@"visible"];
    [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:StatusUpdateUrl httpMethod:@"POST" params:params delegate:self withTag:StatusUpdateUrl];
}

- (void)statusesUpload:(NSString *)text
             imageData:(NSData *)imageData
               visible:(int)visible
                listId:(NSString *)listId
              latitude:(float)latitude
             longitude:(float)longitude
           annotations:(NSString *)annotations
              delegate:(id <StatusManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    NSString *utf8Str = [NSString stringWithCString:[text UTF8String] encoding:NSUTF8StringEncoding];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:6];
    if (utf8Str) {
        [params setObject:utf8Str forKey:@"status"];
    }
    if (listId) {
        [params setObject:listId forKey:@"list_id"];
    }
    if (latitude != 0) {
        [params setObject:[NSString stringWithFormat:@"%f",latitude] forKey:@"lat"];
    }
    if (longitude != 0) {
        [params setObject:[NSString stringWithFormat:@"%f",longitude] forKey:@"long"];
    }
    if (imageData) {
        [params setObject:imageData forKey:@"pic"];
    }
    [params setObject:[NSString stringWithFormat:@"%d",visible] forKey:@"visible"];
    [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:StatusUplaodUrl httpMethod:@"POST" params:params delegate:self withTag:StatusUplaodUrl];
}

- (NSString *)getThumbImageWithStatusId:(long long)Id
{
    NSString *saveDir = [[FileManager getDocumentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Status/%lld",Id]];
    NSString *filePath = [saveDir stringByAppendingPathComponent:@"contentImage"];
    return filePath;
}

- (NSString *)getBigImageWithStatusId:(long long)Id
{
    NSString *saveDir = [[FileManager getDocumentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Status/%lld",Id]];
    NSString *filePath = [saveDir stringByAppendingPathComponent:@"contentBigImage"];
    return filePath;
}

- (void)getStatusContentImageWithStatusId:(long long)Id
                                      url:(NSString *)url
                                 delegate:(id <StatusManagerDelegate>)theDelegate
{
    
    [self registeDelegate:theDelegate];
    NSString *filePath = [self getThumbImageWithStatusId:Id];
    if ([FileManager isExist:filePath]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(OnGetStatusContentImageSuc: statusId:)]) {
            [self.delegate OnGetStatusContentImageSuc:filePath statusId:Id];
        }
    }else{
        if ([_mapDic objectForKey:[NSString stringWithFormat:@"%lld",Id]] == nil) {
            [_mapDic setObject:filePath forKey:[NSString stringWithFormat:@"%lld",Id]];
            [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:url httpMethod:@"GET" params:nil delegate:self withTag:[NSString stringWithFormat:@"%lld",Id]];
        }
    }
}

- (void)getStatusContentBigImageWithStatusId:(long long)Id
                                         url:(NSString *)url
                                    delegate:(id <StatusManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    NSString *filePath = [self getBigImageWithStatusId:Id];
    if ([FileManager isExist:filePath]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(OnGetStatusContentBigImageSuc: statusId:)]) {
            [self.delegate OnGetStatusContentBigImageSuc:filePath statusId:Id];
        }
    }else{
        if ([_mapDic objectForKey:[NSString stringWithFormat:@"%lld",Id]] == nil) {
            [_mapDic setObject:filePath forKey:[NSString stringWithFormat:@"%lld",Id]];
            [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:url httpMethod:@"GET" params:nil delegate:self withTag:[NSString stringWithFormat:@"%lld",Id]];
        }
    }
}

- (void)deleteStatusWithUserId:(long long)statusId
                      delegate:(id <StatusManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",statusId],@"id",nil];
    [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:DeleteStatusUrl httpMethod:@"POST" params:param delegate:self withTag:DeleteStatusUrl];
}

- (void)statusRepostWithStatusId:(long long)statusId
                      statusText:(NSString *)text
                      is_comment:(int)is_comment
                        delegate:(id <StatusManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%lld",statusId] forKey:@"id"];
    [params setObject:text forKey:@"status"];
    [params setObject:[NSString stringWithFormat:@"%d",is_comment] forKey:@"is_comment"];
    [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:RepostStatusUrl httpMethod:@"POST" params:params delegate:self withTag:RepostStatusUrl];
}

#pragma mark -WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnStatusFailed:)]) {
        [self.delegate OnStatusFailed:error.localizedDescription];
    }
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSDictionary *dataDic = [result objectFromJSONString];
    if ([request.tag isEqualToString:StatusPublicTimeLineUrl]) {
        @autoreleasepool {
            NSMutableArray *statuses = [dataDic objectForKey:@"statuses"];
            NSMutableArray *statusobjs = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *status in statuses) {
                [statusobjs addObject:[WeiboStructureParser statusParserByParam:status]];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(OnGetStatusPublicTimeLineSuc:)]) {
                [self.delegate OnGetStatusPublicTimeLineSuc:statusobjs];
            }
        }
    }else if ([request.tag isEqualToString:StatusUpdateUrl]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(OnStatusUpdateSuc)]) {
            [self.delegate OnStatusUpdateSuc];
        }
    }else if ([request.tag isEqualToString:StatusUplaodUrl]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(OnStatusUpdateSuc)]) {
            [self.delegate OnStatusUpdateSuc];
        }
    }else if ([request.tag isEqualToString:StatusHomeTimeLineUrl]){
        NSMutableArray *statuses = [dataDic objectForKey:@"statuses"];
        NSMutableArray *statusobjs = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *status in statuses) {
            [statusobjs addObject:[WeiboStructureParser statusParserByParam:status]];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(OnGetStatusHomeTimeLineSuc:)]) {
            [self.delegate OnGetStatusHomeTimeLineSuc:statusobjs];
        }
    }else if ([request.tag isEqualToString:StatusUserTimeLineUrl]) {
        @autoreleasepool {
            NSMutableArray *statuses = [dataDic objectForKey:@"statuses"];
            NSMutableArray *statusobjs = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *status in statuses) {
                [statusobjs addObject:[WeiboStructureParser statusParserByParam:status]];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(OnGetStatusUserTimeLineSuc:)]) {
                [self.delegate OnGetStatusUserTimeLineSuc:statusobjs];
            }
        }
    }else if ([request.tag isEqualToString:RepostStatusUrl]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(OnReportStatusSuc)]) {
            [self.delegate OnReportStatusSuc];
        }
    }
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
{
    if ([request.tag isEqualToString:DeleteStatusUrl]) {
        NSDictionary *statusDic = [data objectFromJSONData];
        if ([statusDic objectForKey:@"error"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(OnStatusFailed:)]) {
                [self.delegate OnStatusFailed:[statusDic objectForKey:@"error"]];
            }
        }else{
            WeiboStatus *status = [WeiboStructureParser statusParserByParam:statusDic];
            if (status != nil) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(OnDeleteStatusSuc:)]) {
                    [self.delegate OnDeleteStatusSuc:status.Id];
                }
            }
        }
    }
    if ([_mapDic objectForKey:request.tag]) {
        NSString *filePath = [_mapDic objectForKey:request.tag];
        [_mapDic removeObjectForKey:request.tag];
        if ([FileManager saveFile:filePath andData:data]) {
            if ([[filePath lastPathComponent] isEqualToString:@"contentImage"]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(OnGetStatusContentImageSuc: statusId:)]) {
                    [self.delegate OnGetStatusContentImageSuc:filePath statusId:[request.tag longLongValue]];
                }
            }else if ([[filePath lastPathComponent] isEqualToString:@"contentBigImage"]){
                if (self.delegate && [self.delegate respondsToSelector:@selector(OnGetStatusContentBigImageSuc: statusId:)]) {
                    [self.delegate OnGetStatusContentBigImageSuc:filePath statusId:[request.tag longLongValue]];
                }
            }
        }else{
            DLog(@"Error StatusManager didFinishLoadingWithDataResult 写文件失败");
        }
    }
}

@end
