#import "AppDelegate.h"
#import <React/RCTBundleURLProvider.h>
#import "BoostDelegate.h"
#import <flutter_boost/FlutterBoost.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"yhec";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};

  
  //创建代理，做初始化操作
  BoostDelegate* delegate = [[BoostDelegate alloc] init];
  [FlutterBoost.instance setup:application delegate:delegate callback:^(FlutterEngine *engine) {
      
  }];
  
  // RN处理
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
