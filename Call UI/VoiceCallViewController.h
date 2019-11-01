//
//  VoiceCallViewController.h
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/30.
//  Copyright © 2019 andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongCallLib/RongCallLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface VoiceCallViewController : UIViewController

@property (nonatomic, weak) RCCallSession *callSession;

- (void)startTimer;

@end

NS_ASSUME_NONNULL_END
