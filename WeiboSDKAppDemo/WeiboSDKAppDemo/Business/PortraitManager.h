//
//  PortraitManager.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-2.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "BaseManager.h"

typedef enum PortraitType{
    PortraitType_thumbnail,
    PortraitType_big,
    PortraitType_hd
}PortraitType;

@interface Portrait : NSObject

@property (nonatomic, assign)long long userId;
@property (nonatomic, assign)PortraitType type;
@property (nonatomic, copy)NSString *thumbnailPath;
@property (nonatomic, copy)NSString *bigPath;
@property (nonatomic, copy)NSString *hdPath;

@end

@protocol PortraitManagerDelegate <NSObject>
@optional

- (void)OnPortraitSuc:(Portrait *)portrait;

- (void)OnPortraitFailed:(NSString *)errorMsg;

@end

@interface PortraitManager : BaseManager
{
    NSMutableDictionary *_mapDic;
}

@property (nonatomic, assign)id <PortraitManagerDelegate> delegate;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(PortraitManager);

- (NSString *)getPortraitWithUserId:(long long)userId
                       portraitType:(PortraitType)type;

- (void)getPortraitWithUrl:(NSString *)url
                    userId:(long long)userId
                      type:(PortraitType)type
                  delegate:(id <PortraitManagerDelegate>)theDelegate;

@end
