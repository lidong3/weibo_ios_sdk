//
//  RegisterManager.m
//  HelloApplink
//
//  Created by Peter on 13-11-25.
//
//

#import "RegisterManager.h"

@implementation RegisterManager

SYNTHESIZE_SINGLETON_FOR_CLASS(RegisterManager);

@synthesize delegate;
@synthesize isRegisterSuc;

#pragma mark -WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSDictionary *userInfo = [response userInfo];
    DLog(@"didReceiveWeiboResponse response.statusCode = %ld",(long)response.statusCode);
    NSString *errorMsg = nil;
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:
        {
            [self saveAppToken:[userInfo objectForKey:@"access_token"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(OnAuthorizeSuc)]) {
                [self.delegate OnAuthorizeSuc];
            }
        }
            break;
        case WeiboSDKResponseStatusCodeUserCancel:
        {
            errorMsg = @"用户取消发送";
        }
            break;
        case WeiboSDKResponseStatusCodeSentFail:
        {
            errorMsg = @"发送失败";
        }
            break;
        case WeiboSDKResponseStatusCodeAuthDeny:
        {
            errorMsg = @"授权失败";
        }
            break;
        case WeiboSDKResponseStatusCodeUserCancelInstall:
        {
            errorMsg = @"用户取消安装微博客户端";
        }
            break;
        case WeiboSDKResponseStatusCodeUnsupport:
        {
            errorMsg = @"不支持的请求";
        }
            break;
        case WeiboSDKResponseStatusCodeUnknown:
        {
            errorMsg = @"未知错误";
        }
            break;
        default:
            break;
    }
    if (errorMsg) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(OnAuthorizeFailed:)]) {
            [self.delegate OnAuthorizeFailed:errorMsg];
        }
    }
}

#pragma mark -Instance Method

- (void)registeDelegate:(id)theDelegate
{
    self.delegate = theDelegate;
}

- (void)unRegisteDelegate
{
    self.delegate = nil;
}

- (BOOL)registerApp
{
    [WeiboSDK enableDebugMode:YES];
    self.isRegisterSuc = [WeiboSDK registerApp:APPKEY];
    return self.isRegisterSuc;
}

- (void)saveAppToken:(NSString *)token
{
    if (token) {
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:APPToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        DLog(@"error UserToken = nil");
    }
}

- (NSString *)getAppToken
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:APPToken];
}

- (void)authorize:(id <RegisterManagerDelegate>)theDelegate
{
    [self registeDelegate:theDelegate];
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = APPREDIRECTURL;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"LogonManager",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

@end
