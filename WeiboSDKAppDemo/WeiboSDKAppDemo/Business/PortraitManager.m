//
//  PortraitManager.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-2.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "PortraitManager.h"
#import "FileManager.h"
#import "RegisterManager.h"

@implementation Portrait

@synthesize userId;
@synthesize type;
@synthesize thumbnailPath;
@synthesize bigPath;
@synthesize hdPath;

@end

@implementation PortraitManager

@synthesize delegate;

SYNTHESIZE_SINGLETON_FOR_CLASS(PortraitManager);

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

- (NSString *)getPortraitWithUserId:(long long)userId
                       portraitType:(PortraitType)type
{
    NSString *saveDir = [[FileManager getDocumentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Portrait/%lld",userId]];
    NSString *filePath = nil;
    switch (type) {
        case PortraitType_thumbnail:
        {
            filePath = [saveDir stringByAppendingPathComponent:@"portrait_thumbnail"];
        }
            break;
        case PortraitType_big:
        {
            filePath = [saveDir stringByAppendingPathComponent:@"portrait_big"];
        }
            break;
        case PortraitType_hd:
        {
            filePath = [saveDir stringByAppendingPathComponent:@"portrait_hd"];
        }
            break;
        default:
            break;
    }
    return filePath;
}

- (void)getPortraitWithUrl:(NSString *)url
                    userId:(long long)userId
                      type:(PortraitType)type
                  delegate:(id <PortraitManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    Portrait *portrait = [[Portrait alloc] init];
    portrait.type = type;
    portrait.userId = userId;
    NSString *filePath = [self getPortraitWithUserId:userId portraitType:type];
    if ([FileManager isExist:filePath]) {
        switch (type) {
            case PortraitType_thumbnail:
            {
                portrait.thumbnailPath = filePath;
            }
                break;
            case PortraitType_big:
            {
                portrait.bigPath = filePath;
            }
                break;
            case PortraitType_hd:
            {
                portrait.hdPath = filePath;
            }
                break;
            default:
                break;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(OnPortraitSuc:)]) {
            [self.delegate OnPortraitSuc:portrait];
        }
    }else{
        if ([_mapDic objectForKey:url] == nil) {
            [_mapDic setObject:portrait forKey:url];
            [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:url httpMethod:@"GET" params:nil delegate:self withTag:url];
        }
    }
}

#pragma mark -WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnPortraitFailed:)]) {
        [self.delegate OnPortraitFailed:error.localizedDescription];
    }
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
{
    Portrait *portrait = [_mapDic objectForKey:request.tag];
    [_mapDic removeObjectForKey:request.tag];
    NSString *saveDir = [[FileManager getDocumentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Portrait/%lld",portrait.userId]];
    NSString *filePath = nil;
    switch (portrait.type) {
        case PortraitType_thumbnail:
        {
            filePath = [saveDir stringByAppendingPathComponent:@"portrait_thumbnail"];
            if ([FileManager saveFile:filePath andData:data]) {
                portrait.thumbnailPath = filePath;
            }
        }
            break;
        case PortraitType_big:
        {
            filePath = [saveDir stringByAppendingPathComponent:@"portrait_big"];
            if ([FileManager saveFile:filePath andData:data]) {
                portrait.bigPath = filePath;
            }
        }
            break;
        case PortraitType_hd:
        {
            filePath = [saveDir stringByAppendingPathComponent:@"portrait_hd"];
            if ([FileManager saveFile:filePath andData:data]) {
                portrait.hdPath = filePath;
            }
        }
            break;
        default:
            break;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnPortraitSuc:)]) {
        [self.delegate OnPortraitSuc:portrait];
    }
}

@end
