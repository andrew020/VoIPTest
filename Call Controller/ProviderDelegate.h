//
//  ProviderDelegate.h
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/30.
//  Copyright © 2019 andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CallKit/CallKit.h>
#import "CallController.h"
#import "Call.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProviderDelegate : NSObject <CXProviderDelegate>

@property (nonatomic, strong) CallController *callController;
@property (nonatomic, strong) CXProvider *provider;

- (instancetype)initWithCallController:(CallController *)callController;
- (void)reportNewIncomingCallWithUUID:(NSUUID *)uuid callerName:(NSString *)callerName callId:(NSString *)callId isVideo:(BOOL)isVideo completion:(void(^)(Call *newCall, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
