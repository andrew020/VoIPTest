//
//  Call.h
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/30.
//  Copyright © 2019 andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongCallLib/RongCallLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface Call : NSObject <RCCallSessionDelegate>

@property (nonatomic, strong) NSUUID *uuid;
@property (nonatomic, strong) RCCallSession *session;

@property (nonatomic, copy) void(^didConnected)(void);
@property (nonatomic, copy) void(^didDisconnected)(void);

- (void)accept;
- (void)hangup;

@end

NS_ASSUME_NONNULL_END
