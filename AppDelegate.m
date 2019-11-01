//
//  AppDelegate.m
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/29.
//  Copyright © 2019 andrew. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMLib/RongIMLib.h>
#import <UserNotifications/UserNotifications.h>
#import <PushKit/PushKit.h>
#import "NSData+PushToken.h"
#import "RCIMClient+Private.h"
#import <RongCallLib/RongCallLib.h>
#import "CallController.h"
#import "Call.h"
#import "ProviderDelegate.h"

NSNotificationName NSNotificationVoIPPushTokenUpdate = @"kVoIPPushTokenUpdate";

@interface AppDelegate () <PKPushRegistryDelegate, RCCallReceiveDelegate>

@property (nonatomic, strong) RCIMClient *imClient;
@property (nonatomic, strong) CallController *callController;
@property (nonatomic, strong) ProviderDelegate *providerDelegate;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.callController = [[CallController alloc] init];
    self.providerDelegate = [[ProviderDelegate alloc] initWithCallController:self.callController];
    
    ///**********
    // 融云集成，用以测试
    self.imClient = [RCIMClient sharedRCIMClient];
    [self.imClient initWithAppKey:@"25wehl3u2sk5w"];
    [self.imClient connectWithToken:@"LaN1yqHFIs58Vcdr46+sqPM2BghZD3CiZcSqCDMrVTX0vR+29cp+jYTHPv6fpR5WA+SAebt/+hmh3R/CMq6CSA==" success:^(NSString *userId) {
        [[RCCallClient sharedRCCallClient] setDelegate:self];
    } error:^(RCConnectErrorCode status) {

    } tokenIncorrect:nil];
    ///**********
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        });
    }];

    PKPushRegistry *voipPushRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    voipPushRegistry.delegate = self;
    voipPushRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
        
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [deviceToken pushTokenString];
    if (token.length == 0) {
        return ;
    }
    
    NSLog(@"normal push token: %@", token);
    [self.imClient setDeviceToken:token];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    completionHandler(UIBackgroundFetchResultNoData);
}

#pragma mark -

- (void)incomingCall:(NSString *)text {
    [_providerDelegate reportNewIncomingCallWithUUID:[NSUUID UUID] callerName:text callId:@"123" isVideo:NO completion:^(Call * _Nonnull newCall, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - PKPushRegistryDelegate

- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)pushCredentials forType:(PKPushType)type {
    NSString *token = [pushCredentials.token pushTokenString];
    if (token.length == 0) {
        return ;
    }
    
    NSLog(@"voip push token: %@", token);
    self.voipPushToken = token;
    [self.imClient setVoIPDeviceToken:token];
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(PKPushType)type withCompletionHandler:(void (^)(void))completion {
    [self incomingCall:@"AppDelegate触发"];
    completion();
}

#pragma mark - RCCallReceiveDelegate

- (void)didReceiveCall:(RCCallSession *)callSession {
    
}

- (void)didReceiveCallRemoteNotification:(NSString *)callId inviterUserId:(NSString *)inviterUserId mediaType:(RCCallMediaType)mediaType userIdList:(NSArray *)userIdList userDict:(NSDictionary *)userDict {
    [self incomingCall:@"RCCallReceiveDelegate触发"];
}

- (void)didCancelCallRemoteNotification:(NSString *)callId inviterUserId:(NSString *)inviterUserId mediaType:(RCCallMediaType)mediaType userIdList:(NSArray *)userIdList {

}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

@end
