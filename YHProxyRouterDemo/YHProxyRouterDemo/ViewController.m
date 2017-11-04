//
//  ViewController.m
//  YHProxyRouterDemo
//
//  Created by apple on 2017/11/4.
//  Copyright © 2017年 玉河川. All rights reserved.
//

#import "ViewController.h"
#import "YHProxy.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self frisWayFunction];
    // Do any additional setup after loading the view, typically from a nib.
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
