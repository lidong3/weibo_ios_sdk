//
//  CommentManager.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-5.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "CommentManager.h"
#import "RegisterManager.h"

#define CommentsShowUrl  @"https://api.weibo.com/2/comments/show.json"
#define CommentCreateUrl @"https://api.weibo.com/2/comments/create.json"

@implementation CommentManager

@synthesize delegate;

SYNTHESIZE_SINGLETON_FOR_CLASS(CommentManager);

- (void)registeDelegate:(id)theDelegate
{
    self.delegate = theDelegate;
}

- (void)unRegisteDelegate
{
    self.delegate = nil;
}

- (void)getCommentListWithStatusId:(long long)Id
                             count:(int)count
                          delegate:(id <CommentManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%lld",Id] forKey:@"id"];
    [params setObject:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
    [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:CommentsShowUrl httpMethod:@"GET" params:params delegate:self withTag:CommentsShowUrl];
}

- (void)commentCreateWithComment:(NSString *)comment
                        statusId:(long long)statusId
                     comment_ori:(int)ori
                        delegate:(id <CommentManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%lld",statusId] forKey:@"id"];
    [params setObject:comment forKey:@"comment"];
    [params setObject:[NSString stringWithFormat:@"%d",ori] forKey:@"comment_ori"];
    [WBHttpRequest requestWithAccessToken:[[RegisterManager sharedRegisterManager] getAppToken] url:CommentCreateUrl httpMethod:@"POST" params:params delegate:self withTag:CommentCreateUrl];
}

#pragma mark -WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OnCommentFailed:)]) {
        [self.delegate OnCommentFailed:error.localizedDescription];
    }
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSDictionary *dataDic = [result objectFromJSONString];
    if ([request.tag isEqualToString:CommentsShowUrl]) {
        @autoreleasepool {
            NSArray *comments = [dataDic objectForKey:@"comments"];
            NSMutableArray *commentobjs = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *comment in comments) {
                [commentobjs addObject:[WeiboStructureParser commentParserByParam:comment]];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(OnGetCommentListSuc:)]) {
                [self.delegate OnGetCommentListSuc:commentobjs];
            }
        }
    }else if ([request.tag isEqualToString:CommentCreateUrl]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(OnCommentCreateSuc)]) {
            [self.delegate OnCommentCreateSuc];
        }
    }
}

@end
