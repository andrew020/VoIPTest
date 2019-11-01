//
//  NSString+PushToken.h
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/29.
//  Copyright © 2019 andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (PushToken)

- (NSString * __nullable)pushTokenString;

@end

NS_ASSUME_NONNULL_END
