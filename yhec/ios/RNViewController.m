//
//  RNViewController.m
//  yhec
//
//  Created by zjun on 2023/6/25.
//

#import "RNViewController.h"
//#import <React/RCTRootView.h>
#import "AppDelegate.h"
#import <React-RCTAppDelegate/RCTAppSetupUtils.h>
#import "ReactBridge.h"


@interface RNViewController ()


@end

@implementation RNViewController

- (void)loadView {
  [super loadView];

  NSDictionary *initProps = [self prepareInitialProps];
  UIView *rootView = [self createRootViewWithBridge:ReactBridge.share.bridge moduleName:@"yhec" initProps:initProps];
  self.view = rootView;
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = UIColor.yellowColor;
}


- (UIView *)createRootViewWithBridge:(RCTBridge *)bridge
                          moduleName:(NSString *)moduleName
                           initProps:(NSDictionary *)initProps
{
  BOOL enableFabric = NO;
#if RCT_NEW_ARCH_ENABLED
  enableFabric = self.fabricEnabled;
#endif
  UIView *rootView = RCTAppSetupDefaultRootView(bridge, moduleName, initProps, enableFabric);
  if (@available(iOS 13.0, *)) {
    rootView.backgroundColor = [UIColor systemBackgroundColor];
  } else {
    rootView.backgroundColor = [UIColor whiteColor];
  }

  return rootView;
}


- (NSDictionary *)prepareInitialProps
{
  NSMutableDictionary *initProps = self.initialProps ? [self.initialProps mutableCopy] : [NSMutableDictionary new];

#ifdef RCT_NEW_ARCH_ENABLED
  // Hardcoding the Concurrent Root as it it not recommended to
  // have the concurrentRoot turned off when Fabric is enabled.
  initProps[kRNConcurrentRoot] = @([self fabricEnabled]);
#endif

  return initProps;
}




@end
