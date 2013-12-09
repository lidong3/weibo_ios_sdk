//
//  AVFileManager.m
//  AVVideoFramework
//
//  Created by Peter on 13-7-30.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

//获取应用程序路径
+(NSString *)getApplicationPath
{
    return NSHomeDirectory();
}

//提供获取document路径
+(NSString *)getDocumentPath
{
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	return [filePaths objectAtIndex: 0];
}

//获取cache缓存路径
+(NSString *)getCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}

//获取temp路径
+(NSString *)getTempPath
{
    return NSTemporaryDirectory();
}

+(BOOL)isExist:(NSString *)fileFullPath               //判断文件是否存在
{
    BOOL flag = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:fileFullPath]) {
        flag = YES;
    }
    else
    {
        flag = NO;
    }
    
    return flag;
}

+(BOOL)removeDic:(NSString *)dic
{
    BOOL ret = YES;
    NSArray *contents = [self getFileListInDirPath:dic];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        if (![[NSFileManager defaultManager] removeItemAtPath:[dic stringByAppendingPathComponent:filename] error:NULL]) {
            ret = NO;
        }
    }
    return ret;
}

+(BOOL)removeFile:(NSString *)fileFullPath            //删除文件
{
    BOOL flag = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:fileFullPath]) {
        if (![fileManager removeItemAtPath:fileFullPath error:nil]) {
            flag = NO;
        }
    }
    return flag;
}

+(BOOL)createAtDir:(NSString *)dirPath
{
    BOOL ret = YES;
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:dirPath];
    if(!isDirExist)
    {
        NSError *error;
        BOOL bCreateDir = [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(!bCreateDir){
            ret = NO;
            NSLog(@"createDir Failed. error = %@",error);
        }
    }
    return ret;
}

+(BOOL)createDir:(NSString *)dirPath
{
    BOOL ret = YES;
    NSString *header = [NSString stringWithString:dirPath];
    NSMutableArray *stack = [NSMutableArray arrayWithCapacity:5];
    while (![self isExist:header]) {
        [stack addObject:[header lastPathComponent]];
        header = [header stringByDeletingLastPathComponent];
    }
    NSString *lastobj = nil;
    while ([stack count]> 0 && (lastobj = [stack lastObject])) {
        header = [header stringByAppendingPathComponent:lastobj];
        ret = [self createAtDir:header];
        if (!ret) {
            return ret;
        }
        if ([stack count]>0) {
            [stack removeLastObject];
        }
    }
    return ret;
}

+(BOOL)createFileAtPath:(NSString *)filePath
{
    BOOL ret = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        ret = [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    return ret;
}

+(BOOL)createFile:(NSString *)filePath
{
    BOOL ret = YES;
    NSString *header = [NSString stringWithString:filePath];
    NSMutableArray *stack = [NSMutableArray arrayWithCapacity:5];
    while (![self isExist:header]) {
        [stack addObject:[header lastPathComponent]];
        header = [header stringByDeletingLastPathComponent];
    }
    NSString *lastobj = nil;
    while ([stack count]> 1 && (lastobj = [stack lastObject])) {
        header = [header stringByAppendingPathComponent:lastobj];
        ret = [self createAtDir:header];
        if (!ret) {
            return ret;
        }
        [stack removeLastObject];
    }
    if ([stack count] == 1) {
        //最后一个是文件名
        header = [header stringByAppendingPathComponent:[stack lastObject]];
        ret = [self createFileAtPath:header];
    }
    return ret;
}

+(BOOL)saveFile:(NSString *)fileFullPath andData:(NSData *)data
{
    BOOL ret = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileFullPath]) {
        ret = [self createFile:fileFullPath];
    }
    if (ret) {
        [data writeToFile:fileFullPath atomically:YES];
    }else{
        NSLog(@"createFileAtPath failed");
    }
    return ret;
}

+(BOOL)moveFileFromPath:(NSString *)from toPath:(NSString *)to {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:from])
        return NO;
    
    if ([fileManager fileExistsAtPath:to])
        [self removeFile:to];
 
    NSString *headerComponent = [to stringByDeletingLastPathComponent];
    if ([self createAtDir:headerComponent])
        return [fileManager moveItemAtPath:from toPath:to error:nil];
    else
        return NO;
}

+(BOOL)copyFIleFromPath:(NSString *)from toPath:(NSString *)to {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:from])
        return NO;
    
    if ([fileManager fileExistsAtPath:to])
        [self removeFile:to];
    
    NSString *headerComponent = [to stringByDeletingLastPathComponent];
    if ([self createAtDir:headerComponent])
        return [fileManager copyItemAtPath:from toPath:to error:nil];
    else
        return NO;
}

+(NSArray *)getFileListInDirPath:(NSString *)dirPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:dirPath error:&error];
    if (error) {
        NSLog(@"getFileListInDirPath error = %@",error);
    }
    return fileList;
}


//获取文件属性
+(unsigned long long)getFileSize:(NSString *)fileFullPath      //获取文件大小
{
    unsigned long long fileLength = 0;
    NSNumber *fileSize;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:fileFullPath error:nil];
    
    if ((fileSize = [fileAttributes objectForKey:NSFileSize])) {
        fileLength = [fileSize unsignedLongLongValue];
    }
    
    return fileLength;
}


+(NSString *)getFileCreateDate:(NSString *)fileFullPath          //获取文件创建日期
{
    NSString *fileCreateDate = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:fileFullPath error:nil];
    fileCreateDate = [fileAttributes objectForKey:NSFileCreationDate];
    
    return fileCreateDate;
}


+(NSString *)getFileOwner:(NSString *)fileFullPath             //获取文件所有者
{
    NSString *fileOwner = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:fileFullPath error:nil];
    fileOwner = [fileAttributes objectForKey:NSFileOwnerAccountName];
    
    return fileOwner;
}


+(NSDate *)getFileChangeDate:(NSString *)fileFullPath          //获取文件更改日期
{
    NSDate *date = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:fileFullPath error:nil];
    date = [fileAttributes objectForKey:NSFileModificationDate];
    
    return date;
}



@end
