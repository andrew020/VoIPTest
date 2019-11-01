//
//  ProviderDelegate.m
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/30.
//  Copyright © 2019 andrew. All rights reserved.
//

#import "ProviderDelegate.h"

@implementation ProviderDelegate

+ (CXProviderConfiguration *)providerConfiguration {
    static CXProviderConfiguration *providerConfiguration = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        providerConfiguration = [[CXProviderConfiguration alloc] initWithLocalizedName:@"memeChat"];
        providerConfiguration.supportsVideo = YES;
        providerConfiguration.includesCallsInRecents = NO;
        providerConfiguration.supportedHandleTypes = [NSSet setWithObject:@(CXHandleTypeGeneric)];
    });
    return providerConfiguration;
}

- (instancetype)initWithCallController:(CallController *)callController {
    if (self = [super init]) {
        self.callController = callController;
        
        self.provider = [[CXProvider alloc] initWithConfiguration:[ProviderDelegate providerConfiguration]];
        [self.provider setDelegate:self queue:dispatch_get_main_queue()];
    }
    return self;
}

- (void)reportNewIncomingCallWithUUID:(NSUUID *)uuid callerName:(NSString *)callerName callId:(NSString *)callId isVideo:(BOOL)isVideo completion:(void(^)(Call *newCall, NSError *error))completion {
    CXHandle *handle = [[CXHandle alloc] initWithType:CXHandleTypeGeneric value:callId];
    
    CXCallUpdate *callUpdate = [[CXCallUpdate alloc] init];
    callUpdate.remoteHandle = handle;
    callUpdate.localizedCallerName = callerName;
    callUpdate.hasVideo = isVideo;
    callUpdate.supportsDTMF = NO;
    
    __weak typeof(self) objWeak = self;
    [self.provider reportNewIncomingCallWithUUID:uuid update:callUpdate completion:^(NSError * _Nullable error) {
        Call *call = nil;
        if (!error) {
            call = [[Call alloc] init];
            call.uuid = uuid;
            
            [objWeak.callController addCall:call];
            
            __weak typeof(call) callWeak = call;
            call.didConnected = ^{
                [objWeak.callController presentVoiceController];
            };
            call.didDisconnected = ^{
                [objWeak.callController dismissVoiceController];
                [objWeak.callController endCallWithUUID:callWeak];
            };
        }
        if (completion) {
            completion(call, error);
        }
    }];
}

#pragma mark - CXProviderDelegate

#pragma mark 接入电话

//点击接听按钮的回调
- (void)provider:(CXProvider *)provider performAnswerCallAction:(CXAnswerCallAction *)action {
    Call *call = [self.callController callWithUUID:action.callUUID];
    if (!call) {
        [action fail];
        return;
    }
    
    [call accept];
    [action fulfill];
}

//点击结束按钮的回调
- (void)provider:(CXProvider *)provider performEndCallAction:(CXEndCallAction *)action {
    Call *call = [self.callController callWithUUID:action.callUUID];
    if (!call) {
        [action fail];
        return;
    }
    
    [call hangup];
    [action fulfill];
    
    [self.callController removeCall:call];
}

#pragma mark 呼出电话

//呼出电话开始
- (void)provider:(CXProvider *)provider performStartCallAction:(CXStartCallAction *)action {
    
}

#pragma mark 通用

//- (void)provider:(CXProvider *)provider didActivateAudioSession:(AVAudioSession *)audioSession {
//}

@end
