//
//  BaseManager.h
//  HelloApplink
//
//  Created by Peter on 13-11-25.
//
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "WeiboSDK.h"
#import "Define.h"
#import "JSONKit.h"
#import "WeiboStructureParser.h"

@interface BaseManager : NSObject <WBHttpRequestDelegate>

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(BaseManager);

//提供给外部  界面按照需求注册和注销
- (void)registeDelegate:(id)theDelegate;
- (void)unRegisteDelegate;

@end
