//
//  ViewController.m
//  YHProxyRouterDemo
//
//  Created by apple on 2017/11/4.
//  Copyright © 2017年 玉河川. All rights reserved.
//

#import "ViewController.h"
#import "YHProxy.h"
#import "YHButton.h"

@interface ViewController ()

@property (nonatomic, strong) YHButton *display;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self secondWayFunction];
    // 测试单例 模式
    [self setup];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setup {
    
    CGFloat width = 200;
    CGFloat height = 50;
    CGFloat x = (self.view.bounds.size.width - width) / 2.0;
    CGFloat y1 = 200;
    _display = [[YHButton alloc]initWithFrame:CGRectMake(x, y1, width, height)];
    _display.title = @"下一页";
    _display.buttonColor = [UIColor colorWithRed:70 / 225.0 green:187 / 255.0 blue:38 / 255.0 alpha:1];
    typeof(self) __weak weakSelf = self;
    _display.operation = ^{
        [weakSelf displayAnimation];
    };
    [self.view addSubview:_display];
}

- (void)displayAnimation {
    [self.proxyRouter unregisterAllTarget];
//    Class vc_class = NSClassFromString(@"YHBaseViewController");
//    UIViewController *vc = [[vc_class alloc]init];
//    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self presentViewController:nc animated:YES completion:nil];
}

- (void)frisWayFunction {
    YHProxyRouter *proxyTool = [YHProxyRouter initWithTargets:[self getModels]];
    //1.无参数 方法
    [proxyTool executeMethod:@"modelOneFunction"];
    //2.无参数多个方法
    [proxyTool executeMethods:[self getMethods]];
    //3.一个参数
    [proxyTool executeMethod:@"oneParamWith:" param:@"南风不竞"];
    //4.多个参数
    [proxyTool executeMethod:@"modelTwoParam:bigName:" params:@[@"练峨眉",@"一页书"]];
    
    //注:单个参数 方法名可以省略 :  多个参数方法名不可省略中间的:
    //   如果两个model中  方法名字一样 会调用 Targets数组中靠后的方法
  
}

- (void)secondWayFunction {
    self.proxyRouter.targets = [self getModels];
    //1.无参数 方法
    [self.proxyRouter executeMethod:@"modelOneFunction"];
    //2.无参数多个方法
    [self.proxyRouter executeMethods:[self getMethods]];
    //3.一个参数
    [self.proxyRouter executeMethod:@"oneParamWith:" param:@"南风不竞"];
    //4.多个参数
    [self.proxyRouter executeMethod:@"modelTwoParam:bigName:" params:@[@"练峨眉",@"一页书"]];
    //注:单个参数 方法名可以省略 :  多个参数方法名不可省略中间的:
}


- (NSArray *)getModels {
    return @[@"YHModelOne",
             @"YHModelTwo"];
}

- (NSArray *)getMethods {
    return @[@"modelOneFunction",
             @"modelTwoFunction"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
