//
//  YHProxySingleton.h
//  YHProxyRouterDemo
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 玉河川. All rights reserved.
//

#ifndef YHProxySingleton_h
#define YHProxySingleton_h
/**
 *  单例模式宏模板
 */

#define DEFAULT_ROUTER [YHProxyRouter defaultRouter]

#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)defaultRouter;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)defaultRouter { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [self alloc]; \
}); \
return shared##className; \
}

#endif /* YHProxySingleton_h */
