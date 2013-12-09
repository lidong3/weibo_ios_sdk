//
//  RegisterManager.h
//  HelloApplink
//
//  Created by Peter on 13-11-25.
//
//

#import "BaseManager.h"
#import "WeiboSDK.h"

@protocol RegisterManagerDelegate <NSObject>
@optional
- (void)OnAuthorizeSuc;
- (void)OnAuthorizeFailed:(NSString *)errorMsg;

@end

@interface RegisterManager : BaseManager <WeiboSDKDelegate>

@property (nonatomic, assign)id <RegisterManagerDelegate> delegate;
@property (nonatomic, assign)BOOL isRegisterSuc;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(RegisterManager);

- (void)authorize:(id <RegisterManagerDelegate>)theDelegate;

- (BOOL)registerApp;

- (NSString *)getAppToken;

@end
