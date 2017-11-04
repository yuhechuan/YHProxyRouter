//
//  YHModelOne.m
//  YHMultipleInheritance
//
//  Created by apple on 2017/11/3.
//  Copyright © 2017年 玉河川. All rights reserved.
//

#import "YHModelOne.h"

@implementation YHModelOne

- (void)modelOneFunction {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)modelTwoParam:(NSString *)name bigName:(NSString *)bigName {
    NSLog(@"%@+%@",name,bigName);
}

@end
