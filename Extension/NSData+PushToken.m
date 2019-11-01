//
//  NSString+PushToken.m
//  VoIPTest
//
//  Created by 李宗良 on 2019/10/29.
//  Copyright © 2019 andrew. All rights reserved.
//

#import "NSData+PushToken.h"

@implementation NSData (PushToken)

- (NSString * __nullable)pushTokenString {
    NSUInteger dataLength = self.length;
    if (dataLength == 0) {
        return nil;
    }
      
    const unsigned char *dataBuffer = self.bytes;
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for (int i = 0; i < dataLength; ++i) {
        [hexString appendFormat:@"%02x", dataBuffer[i]];
    }
    
    return hexString;
}

@end
