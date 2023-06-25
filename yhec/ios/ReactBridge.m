//
//  ReactBridge.m
//  yhec
//
//  Created by zjun on 2023/6/25.
//

#import "ReactBridge.h"

@implementation ReactBridge

+ (ReactBridge *)share {
  static ReactBridge* bridge;
  static dispatch_once_t onceToken;
  if (!bridge) {
    dispatch_once(&onceToken, ^{
      bridge = [[ReactBridge alloc] init];
    });
  }
  return bridge;
}


+ (void)configBridge:(RCTBridge *)bridge {
  [self share].bridge = bridge;
}

@end
