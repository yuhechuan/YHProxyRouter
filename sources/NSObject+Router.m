//
//  NSObject+Router.m
//  YHMultipleInheritance
//
//  Created by apple on 2017/11/4.
//  Copyright © 2017年 玉河川. All rights reserved.
//

#import "NSObject+Router.h"
#import <objc/message.h>

@implementation NSObject (Router)

- (YHProxyRouter *)proxyRouter {
    id router = objc_getAssociatedObject(self, @selector(setProxyRouter:));
    if (!router) {
        router = [YHProxyRouter alloc];
        self.proxyRouter = router;
    }
    return router;
}

- (void)setProxyRouter:(YHProxyRouter *)proxyRouter {
     objc_setAssociatedObject(self,_cmd, proxyRouter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
