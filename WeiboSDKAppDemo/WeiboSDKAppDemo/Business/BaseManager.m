//
//  BaseManager.m
//  HelloApplink
//
//  Created by Peter on 13-11-25.
//
//

#import "BaseManager.h"

@implementation BaseManager

SYNTHESIZE_SINGLETON_FOR_CLASS(BaseManager);

- (void)registeDelegate:(id)theDelegate
{
    //子类实现
}

- (void)unRegisteDelegate
{
    
}

#pragma mark -WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
{
    
}

@end
