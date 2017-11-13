//
//  YHBaseViewController.m
//  YHProxyRouterDemo
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 玉河川. All rights reserved.
//

#import "YHBaseViewController.h"
#import "YHProxy.h"

@interface YHBaseViewController ()

@end

@implementation YHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self fourWayFunction];
    // Do any additional setup after loading the view.
}

- (void)setup {
    self.view.backgroundColor = [UIColor cyanColor];
    UIBarButtonItem *leftBar  =[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(popView)];
    self.navigationItem.leftBarButtonItem = leftBar;
}

- (void)popView {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)thridWayFunction {
    DEFAULT_ROUTER.targets = [self getModels];
    //1.无参数 方法
    [DEFAULT_ROUTER executeMethod:@"modelOneFunction"];
    //2.无参数多个方法
    [DEFAULT_ROUTER executeMethods:[self getMethods]];
    //3.一个参数
    [DEFAULT_ROUTER executeMethod:@"oneParamWith:" param:@"南风不竞"];
    //4.多个参数
    [DEFAULT_ROUTER executeMethod:@"modelTwoParam:bigName:" params:@[@"练峨眉",@"一页书"]];
    
}

- (void)fourWayFunction {
    self.defaultRouter.targets = [self getModels];
    //1.无参数 方法
    [self.defaultRouter executeMethod:@"modelOneFunction"];
    //2.无参数多个方法
    [self.defaultRouter executeMethods:[self getMethods]];
    //3.一个参数
    [self.defaultRouter executeMethod:@"oneParamWith:" param:@"南风不竞"];
    //4.多个参数
    [self.defaultRouter executeMethod:@"modelTwoParam:bigName:" params:@[@"练峨眉",@"一页书"]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
