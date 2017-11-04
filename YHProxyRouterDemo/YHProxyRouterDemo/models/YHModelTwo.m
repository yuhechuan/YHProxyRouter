//
//  YHModelTwo.m
//  YHMultipleInheritance
//
//  Created by apple on 2017/11/3.
//  Copyright © 2017年 玉河川. All rights reserved.
//

#import "YHModelTwo.h"

@implementation YHModelTwo

- (void)modelTwoFunction {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)oneParamWith:(NSString *)name {
    NSLog(@"modelTwoWith :%@",name);
}

- (void)twoParamWith:(NSString *)name secondName:(NSString *)secondName {
    NSLog(@"%@+%@",name,secondName);
}

@end
