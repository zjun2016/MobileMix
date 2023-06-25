//
//  BoostDelegate.m
//  yhec
//
//  Created by zjun on 2023/6/25.
//

#import "BoostDelegate.h"
#import "TestViewController.h"
#import "RNViewController.h"
#import "YHNavigationController.h"
#import <flutter_boost/FBFlutterViewContainer.h>


@interface BoostDelegate ()

@property (nonatomic, strong) NSMutableDictionary *resultTable;
@property (nonatomic, strong) YHNavigationController *naC;

@end


@implementation BoostDelegate

- (void)pushNativeRoute:(NSString *)pageName arguments:(NSDictionary *)arguments {
  //用参数来控制是push还是pop
  NSNumber *isPresentNum = arguments[@"isPresent"] ? @(YES): @(NO);
  bool isPresent = [isPresentNum boolValue];
  
  NSNumber *isAnimatedNum = arguments[@"isAnimated"] ? @(YES): @(NO);
  bool isAnimated = [isAnimatedNum boolValue];
  
  UIViewController *targetViewController = [[UIViewController alloc] init];
  
  if([pageName isEqualToString:@"testPage"]){
      //这里接收传入的参数
    NSString *data = arguments[@"data"] ? arguments[@"data"] :@"";
    TestViewController *homeVC = [[TestViewController alloc] init];
    homeVC.dataString = data;
    targetViewController = homeVC;
  }
  else if ([pageName isEqualToString:@"rnPage"]) {
      //这里接收传入的参数
    NSString *data = arguments[@"data"] ? arguments[@"data"] :@"";
    RNViewController *homeVC = [[RNViewController alloc] init];
    homeVC.dataString = data;
    targetViewController = homeVC;
  }
  
  if(isPresent){
    [self.naC presentViewController:targetViewController animated:isAnimated completion:^{
          
    }];
  }else{
    [self.naC pushViewController:targetViewController animated:isAnimated];
  }
  
}


- (void)pushFlutterRoute:(FlutterBoostRouteOptions *)options {
  FBFlutterViewContainer *vc = [[FBFlutterViewContainer alloc] init];
  [vc setName:options.pageName uniqueId:options.uniqueId params:options.arguments opaque:options.opaque];
  
  
  
  //用参数来控制是push还是pop
  NSNumber *isPresentNum = options.arguments[@"isPresent"] ? @(YES): @(NO);
  bool isPresent = [isPresentNum boolValue];
  
  NSNumber *isAnimatedNum = options.arguments[@"isAnimated"] ? @(YES): @(NO);
  bool isAnimated = [isAnimatedNum boolValue];
  
  //对这个页面设置结果
  NSString *uniqueID = [vc uniqueIDString];
  self.resultTable[uniqueID] = options.onPageFinished;
  
  //如果是present模式 ，或者要不透明模式，那么就需要以present模式打开页面
  if(isPresent || !options.opaque){
    [self.naC presentViewController:vc animated:isAnimated completion:^{
          
    }];
  }else{
    [self.naC pushViewController:vc animated:isAnimated];
  }
  
}

- (void)popRoute:(FlutterBoostRouteOptions *)options {
  
  //如果当前被present的vc是container，那么就执行dismiss逻辑
  FBFlutterViewContainer *vc = (FBFlutterViewContainer *)self.naC.presentedViewController;
  if (vc && [[vc uniqueIDString] isEqualToString:options.uniqueId]) {
    //这里分为两种情况，由于UIModalPresentationOverFullScreen下，生命周期显示会有问题
    //所以需要手动调用的场景，从而使下面底部的vc调用viewAppear相关逻辑
    if (vc.modalPresentationStyle == UIModalPresentationOverFullScreen) {
      //这里手动beginAppearanceTransition触发页面生命周期
      [self.naC.topViewController beginAppearanceTransition:YES animated:NO];
      [vc dismissViewControllerAnimated:YES completion:^{
        [self.naC.topViewController endAppearanceTransition];
      }];
    } else {
      //正常场景，直接dismiss
      [vc dismissViewControllerAnimated:YES completion:nil];
    }
  
  } else {
    //pop场景
    //找到和要移除的id对应的vc
    NSArray <UIViewController *>* viewControllers = self.naC.viewControllers;
    if (!viewControllers || viewControllers.count == 0) {
      return;
    }
    UIViewController *containerToRemove;
    NSInteger count = viewControllers.count;
    for (NSInteger i = 0; i < count; i++) {
      FBFlutterViewContainer *container = (FBFlutterViewContainer *)viewControllers[count - i - 1];
      if ([container isKindOfClass:FBFlutterViewContainer.class] && [[container uniqueIDString] isEqualToString:options.uniqueId]) {
        containerToRemove = container;
        break;
      }
    }
    
    if(containerToRemove == nil){
      NSAssert(0, @"uniqueId is wrong!!!");
    }
    
    if (self.naC.topViewController == containerToRemove) {
      [self.naC popViewControllerAnimated:YES];
    } else {
      [containerToRemove removeFromParentViewController];
    }
    
  }
  
  //这里在pop的时候将参数带出,并且从结果表中移除
  void(^onPageFinshed)(NSDictionary* ) = self.resultTable[options.uniqueId];
  if (onPageFinshed) {
    onPageFinshed(options.arguments);
  }
  [self.resultTable removeObjectForKey:options.uniqueId];
}


- (YHNavigationController *)naC {
  if (!_naC) {
    _naC = (YHNavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
  }
  return _naC;
}


@end
