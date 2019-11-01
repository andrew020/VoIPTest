//
//  CallController.m
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/29.
//  Copyright © 2019 andrew. All rights reserved.
//

#import "CallController.h"
#import "VoiceCallViewController.h"
#import <CallKit/CallKit.h>

@interface CallController ()

@property (nonatomic, strong) CXCallController *callController;
@property (nonatomic, strong) NSMutableArray<Call *> *calls;
@property (nonatomic, strong) VoiceCallViewController *voiceCallViewController;

@end

@implementation CallController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.calls = [[NSMutableArray alloc] init];
        self.callController = [[CXCallController alloc] initWithQueue:dispatch_get_main_queue()];
    }
    return self;
}

- (void)addCall:(Call *)call {
    [self.calls addObject:call];
}

- (Call *)callWithUUID:(NSUUID *)uuid {
    for (Call *call in self.calls) {
        if ([call.uuid isEqual:uuid]) {
            return call;
        }
    }
    return nil;
}

- (void)removeCall:(Call *)call {
    [self.calls removeObject:call];
}

- (void)startCallWithHandle:(NSString *)handleString {
    CXHandle *handle = [[CXHandle alloc] initWithType:CXHandleTypeGeneric value:handleString];
    CXStartCallAction *startCallAction = [[CXStartCallAction alloc] initWithCallUUID:[NSUUID UUID] handle:handle];
    CXTransaction *transation = [[CXTransaction alloc] initWithAction:startCallAction];
    [self.callController requestTransaction:transation completion:^(NSError * _Nullable error) {
        
    }];
}

- (void)endCallWithUUID:(Call *)call {
    CXEndCallAction *endCallAction = [[CXEndCallAction alloc] initWithCallUUID:call.uuid];
    CXTransaction *transation = [[CXTransaction alloc] initWithAction:endCallAction];
    [self.callController requestTransaction:transation completion:^(NSError * _Nullable error) {
        
    }];
    
    [self removeCall:call];
}

- (void)presentVoiceController {
    self.voiceCallViewController = [[VoiceCallViewController alloc] init];
    self.voiceCallViewController.callSession = _calls.lastObject.session;
    
    UIViewController *rootViewController = [UIApplication sharedApplication].windows.lastObject.rootViewController;
    __weak typeof(self) objWeak = self;
    [rootViewController presentViewController:self.voiceCallViewController animated:NO completion:^{
        [objWeak.voiceCallViewController startTimer];
    }];
}

- (void)dismissVoiceController {
    [self.voiceCallViewController dismissViewControllerAnimated:NO completion:nil];
}

@end
