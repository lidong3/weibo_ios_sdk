//
//  FileManager.h
//  AVVideoFramework
//
//  Created by Peter on 13-7-30.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

//提供获取document路径
+(NSString *)getDocumentPath;

//获取应用程序路径
+(NSString *)getApplicationPath;

//获取cache缓存路径
+(NSString *)getCachePath;

//获取temp路径
+(NSString *)getTempPath;

//判断文件是否存在
+(BOOL)isExist:(NSString *)fileFullPath;

//删除目录下的所有文件
+(BOOL)removeDic:(NSString *)dic;

//删除文件
+(BOOL)removeFile:(NSString *)fileFullPath;

//创建文件夹 如果中间的文件夹没有生成  也可以默认生成
+(BOOL)createDir:(NSString *)dirPath;

//创建文件  如果中间的文件夹没有生成  也可以默认生成
+(BOOL)createFile:(NSString *)filePath;

//保存文件
+(BOOL)saveFile:(NSString *)fileFullPath
        andData:(NSData *)data;

//移动文件
+(BOOL)moveFileFromPath:(NSString *)from toPath:(NSString *)to;

//拷贝文件
+(BOOL)copyFIleFromPath:(NSString *)from toPath:(NSString *)to;

//获取文件夹下文件列表
+(NSArray *)getFileListInDirPath:(NSString *)dirPath;

//获取文件属性
+(unsigned long long)getFileSize:(NSString *)fileFullPath;      //获取文件大小
+(NSDate *)getFileCreateDate:(NSString *)fileFullPath;          //获取文件创建日期
+(NSString *)getFileOwner:(NSString *)fileFullPath;             //获取文件所有者
+(NSDate *)getFileChangeDate:(NSString *)fileFullPath;          //获取文件更改日期

@end
