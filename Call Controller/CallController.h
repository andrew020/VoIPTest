//
//  CallController.h
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/29.
//  Copyright © 2019 andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Call.h"

NS_ASSUME_NONNULL_BEGIN

@interface CallController : NSObject

- (void)addCall:(Call *)call;
- (Call *)callWithUUID:(NSUUID *)uuid;
- (void)removeCall:(Call *)call;

- (void)startCallWithHandle:(NSString *)handle;
- (void)endCallWithUUID:(Call *)call;

- (void)presentVoiceController;
- (void)dismissVoiceController;

@end

NS_ASSUME_NONNULL_END
