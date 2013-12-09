//
//  StatusManager.h
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-11-29.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "BaseManager.h"

@protocol StatusManagerDelegate <NSObject>

@optional

- (void)OnGetStatusHomeTimeLineSuc:(NSArray *)statues;

- (void)OnGetStatusUserTimeLineSuc:(NSArray *)statuses;

- (void)OnGetStatusPublicTimeLineSuc:(NSArray *)statuses;

- (void)OnStatusUpdateSuc;

- (void)OnGetStatusContentImageSuc:(NSString *)filePath
                          statusId:(long long)Id;

- (void)OnGetStatusContentBigImageSuc:(NSString *)filePath
                             statusId:(long long)Id;

- (void)OnDeleteStatusSuc:(long long)statusId;

- (void)OnReportStatusSuc;

- (void)OnStatusFailed:(NSString *)errorMsg;

@end

@interface StatusManager : BaseManager
{
    //key：微博id value：图片路径
    NSMutableDictionary *_mapDic;
}

@property (nonatomic, assign)id <StatusManagerDelegate> delegate;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(StatusManager);

//通过微博Id获取图片
- (NSString *)getThumbImageWithStatusId:(long long)Id;

//通过微博Id获取大图
- (NSString *)getBigImageWithStatusId:(long long)Id;

//获取最新的公共微博,返回最新的200条公共微博，返回结果非完全实时
//参考文档 http://open.weibo.com/wiki/2/statuses/public_timeline
- (void)getStatusPublicTimeLineWithCount:(int)count
                                delegate:(id <StatusManagerDelegate>)theDelegate;

//参考文档 http://open.weibo.com/wiki/2/statuses/update
- (void)statusesUpdate:(NSString *)text
               visible:(int)visible
                listId:(NSString *)listId
              latitude:(float)latitude
             longitude:(float)longitude
           annotations:(NSString *)annotations
              delegate:(id <StatusManagerDelegate>)theDelegate;

//参考文档 http://open.weibo.com/wiki/2/statuses/upload
- (void)statusesUpload:(NSString *)text
             imageData:(NSData *)imageData
               visible:(int)visible
                listId:(NSString *)listId
              latitude:(float)latitude
             longitude:(float)longitude
           annotations:(NSString *)annotations
              delegate:(id <StatusManagerDelegate>)theDelegate;

//获取首页信息
//参考文档 http://open.weibo.com/wiki/2/statuses/home_timeline
- (void)getStatusHomeTimeLineWithCount:(int)count
                              delegate:(id <StatusManagerDelegate>)theDelegate;

//不支持
- (void)getStatusUserTimeLineWithCount:(int)count
                                userId:(long long)userId
                              delegate:(id <StatusManagerDelegate>)theDelegate;

//获取微博内容图片缩略图
- (void)getStatusContentImageWithStatusId:(long long)Id
                                      url:(NSString *)url
                                 delegate:(id <StatusManagerDelegate>)theDelegate;

//获取微博内容图片大图
- (void)getStatusContentBigImageWithStatusId:(long long)Id
                                         url:(NSString *)url
                                    delegate:(id <StatusManagerDelegate>)theDelegate;

//删除自己发送的微博
- (void)deleteStatusWithUserId:(long long)statusId
                      delegate:(id <StatusManagerDelegate>)theDelegate;

//转发一条微博
//参考文档 http://open.weibo.com/wiki/2/statuses/repost
- (void)statusRepostWithStatusId:(long long)statusId
                      statusText:(NSString *)text
                      is_comment:(int)is_comment
                        delegate:(id <StatusManagerDelegate>)theDelegate;

@end
