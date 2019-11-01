//
//  Call.m
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/30.
//  Copyright © 2019 andrew. All rights reserved.
//

#import "Call.h"

@implementation Call

- (void)setSession:(RCCallSession *)session {
    _session = session;
    [_session setDelegate:self];
}

- (void)accept {
    [_session accept:_session.mediaType];
}

- (void)hangup {
    [_session hangup];
}

#pragma mark - RCCallSessionDelegate

/*!
 通话已接通
 */
- (void)callDidConnect {
    if (self.didConnected) {
        self.didConnected();
    }
}

/*!
 通话已结束
 */
- (void)callDidDisconnect {
    if (self.didDisconnected) {
        self.didDisconnected();
    }
}

/*!
 对端用户正在振铃

 @param userId 用户ID
 */
- (void)remoteUserDidRing:(NSString *)userId {
    
}

/*!
 有用户被邀请加入通话

 @param userId    被邀请的用户ID
 @param mediaType 希望被邀请者使用的媒体类型
 */
- (void)remoteUserDidInvite:(NSString *)userId mediaType:(RCCallMediaType)mediaType {
    
}

/*!
 对端用户加入了通话

 @param userId    用户ID
 @param mediaType 用户的媒体类型
 */
- (void)remoteUserDidJoin:(NSString *)userId mediaType:(RCCallMediaType)mediaType {
    
}

/*!
 对端用户切换了媒体类型

 @param userId    用户ID
 @param mediaType 切换至的媒体类型
 */
- (void)remoteUserDidChangeMediaType:(NSString *)userId mediaType:(RCCallMediaType)mediaType {
    
}

/*!
 对端用户开启或关闭了摄像头的状态

 @param disabled  是否关闭摄像头
 @param userId    用户ID
 */
- (void)remoteUserDidDisableCamera:(BOOL)disabled byUser:(NSString *)userId {
    
}

/*!
 对端用户挂断

 @param userId 用户ID
 @param reason 挂断的原因
 */
- (void)remoteUserDidLeft:(NSString *)userId reason:(RCCallDisconnectReason)reason {
    
}

/*!
 彩铃
 */
- (void)shouldAlertForWaitingRemoteResponse {
    
}

/*!
 来电铃声
 */
- (void)shouldRingForIncomingCall {
    
}

/*!
 停止播放铃声(通话接通或挂断)
 */
- (void)shouldStopAlertAndRing {
    
}

/*!
 通话过程中的错误回调

 @param error 错误码

 @warning
 这个接口回调的错误码主要是为了提供必要的log以及提示用户，如果是不可恢复的错误，SDK会挂断电话并回调callDidDisconnect，App可以在callDidDisconnect中统一处理通话结束的逻辑。
 */
- (void)errorDidOccur:(RCCallErrorCode)error {
    
}

/*!
 当前通话网络状态的回调，该回调方法每两秒触发一次

 @param txQuality   上行网络质量
 @param rxQuality   下行网络质量
 */
- (void)networkTxQuality:(RCCallQuality)txQuality rxQuality:(RCCallQuality)rxQuality {
    
}

///*!
// 当前通话本地视频数据, 用于GPU滤镜处理, 同步返回处理后的同一sampleBuffer对象, 需要本地视频数据时首先调用 RCCallClient.h 中 - (void)setEnableBeauty:(BOOL)enable方法, 该方法默认为NO.
// 若设置setEnableBeauty为Yes, 但未实现processVideoFrame:则使用默认美颜.
// @param sampleBuffer   本地视频数据
// */
//- (CMSampleBufferRef)processVideoFrame:(CMSampleBufferRef)sampleBuffer {
//
//}

@end
