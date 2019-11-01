//
//  AppDelegate.h
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/29.
//  Copyright © 2019 andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSNotificationName NSNotificationVoIPPushTokenUpdate;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) NSString *voipPushToken;

- (void)incomingCall:(NSString *)text;

@end

