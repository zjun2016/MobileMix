//
//  ReactBridge.h
//  yhec
//
//  Created by zjun on 2023/6/25.
//

#import <Foundation/Foundation.h>
#import <React-Core/React/RCTBridge.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReactBridge : NSObject

+ (ReactBridge *)share;

@property (nonatomic, strong) RCTBridge *bridge;


+ (void)configBridge:(RCTBridge *)bridge;


@end

NS_ASSUME_NONNULL_END
