//
//  Define.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-11-28.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#ifndef WeiboSDKAppDemo_Define_h
#define WeiboSDKAppDemo_Define_h

#define APPKEY @"3041567824"
#define APPREDIRECTURL @"https://api.weibo.com/2/oauth2/authorize"

#define APPToken @"APPToken"

#define ForceAuthrize 0

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#endif
