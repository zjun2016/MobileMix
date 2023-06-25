//
//  YHViewController.m
//  yhec
//
//  Created by zjun on 2023/6/25.
//

#import "YHViewController.h"
#import "RNViewController.h"
#import <flutter_boost/FBFlutterViewContainer.h>



@interface YHViewController ()

@end

@implementation YHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = UIColor.whiteColor;
  self.title = @"登录";
  
  
  UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
  [btn1 setTitleColor:UIColor.redColor forState:UIControlStateNormal];
  [btn1.titleLabel setFont:[UIFont systemFontOfSize:16]];
  [btn1 setTitle:@"去RN" forState:UIControlStateNormal];
  [btn1 addTarget:self action:@selector(btn1ClickedAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btn1];
  
  
  UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
  [btn2 setTitleColor:UIColor.cyanColor forState:UIControlStateNormal];
  [btn2.titleLabel setFont:[UIFont systemFontOfSize:16]];
  [btn2 setTitle:@"去Flutter" forState:UIControlStateNormal];
  [btn2 addTarget:self action:@selector(btn2ClickedAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btn2];
}



- (void)btn1ClickedAction:(UIButton *)sender {
  RNViewController *rnC = [[RNViewController alloc] init];
  [self.navigationController pushViewController:rnC animated:YES];
}

- (void)btn2ClickedAction:(UIButton *)sender {
  
  //下面是三个flutter vc
  FBFlutterViewContainer *vc = [[FBFlutterViewContainer alloc] init];
  [vc setName:@"mainPage" uniqueId:nil params:nil opaque:YES];
  [self.navigationController pushViewController:vc animated:YES];
  
}


@end
