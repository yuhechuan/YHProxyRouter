//
//  YHProxyRouter.m
//  YHProxyRouterDemo
//
//  Created by apple on 2017/11/3.
//  Copyright © 2017年 玉河川. All rights reserved.
//

#import "YHProxyRouter.h"
#import <objc/runtime.h>
#import "pthread.h"
@implementation YHProxyRouter {
    NSMutableDictionary <NSString *,id>*_classInfosMap;
    pthread_mutex_t _mutex;
}

SINGLETON_FOR_CLASS(YHProxyRouter);

+ (instancetype)initWithTargets:(NSArray <NSString *>*)targets {
    return [[YHProxyRouter alloc]initWithTargets:targets];
}

- (instancetype)initWithTargets:(NSArray <NSString *>*)targets {
    [self _initializeVariable];
    [self _registerMethodsWithTargets:targets];
    return self;
}

- (void)setTargets:(NSArray *)targets {
    [self _initializeVariable];
    [self _registerMethodsWithTargets:targets];
}

- (void)registerTargetName:(NSString *)targetName {
    [self _registerMethodsWithTargetName:targetName];
}

- (void)unregisterTargetName:(NSString *)targetName {
    [self _unregisterMethodsWithTargetName:targetName];
}

- (void)unregisterAllTarget {
    [self _unregisterAllTarget];
}

- (void)_initializeVariable {
    _classInfosMap = [NSMutableDictionary dictionary];
    pthread_mutex_init(&_mutex, NULL);
}

- (void)_registerMethodsWithTargets:(NSArray <NSString *>*)targets {
     _targets = targets;
    [self _unregisterAllTarget];
    for (NSString *target_name in targets) {
        [self _registerMethodsWithTargetName:target_name];
    }
}

- (void)_registerMethodsWithTargetName:(NSString *)target_name {
    Class target_class = NSClassFromString(target_name);
    id target = [[target_class alloc]init];
    unsigned int numberOfMethods = 0;
    Method *method_list = class_copyMethodList(target_class, &numberOfMethods);
    for (int i = 0; i < numberOfMethods; i ++) {
        [self _registerMethod:method_list[i] target:target];
    }
    free(method_list);
}

- (void)_registerMethod:(Method)temp_method target:(id)target {
    SEL temp_sel = method_getName(temp_method);
    const char *temp_method_name = sel_getName(temp_sel);
    
    pthread_mutex_lock(&_mutex);
    [_classInfosMap setObject:target forKey:[NSString stringWithUTF8String:temp_method_name]];
    pthread_mutex_unlock(&_mutex);
}

- (void)_unregisterMethodsWithTargetName:(NSString *)target_name {
    pthread_mutex_lock(&_mutex);
    [_classInfosMap removeObjectsForKeys:[self _method_list:target_name]];
    pthread_mutex_unlock(&_mutex);
}

- (void)_unregisterAllTarget {
    pthread_mutex_lock(&_mutex);
    [_classInfosMap removeAllObjects];
    pthread_mutex_unlock(&_mutex);
}

- (NSArray <NSString *>*)_method_list:(NSString *)target_name {
    Class target_class = NSClassFromString(target_name);
    unsigned int _count = 0;
    Method *method_list = class_copyMethodList(target_class, &_count);
    NSMutableArray *methods = [NSMutableArray arrayWithCapacity:_count];
    for (int i = 0; i < _count; i ++) {
        [methods addObject:(__bridge id _Nonnull)(method_list[i])];
    }
    free(method_list);
    return methods;
}


#pragma mark - NSProxy override methods
- (void)forwardInvocation:(NSInvocation *)invocation{
    //获取当前选择子
    SEL sel = invocation.selector;
    
    //在字典中查找对应的target
    id target = [self fitterClass:sel];
    
    //检查target
    if (target && [target respondsToSelector:sel]) {
        [invocation invokeWithTarget:target];
    } else {
        [super forwardInvocation:invocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    //在字典中查找对应的target
    id target = [self fitterClass:sel];
    //检查target
    if (target && [target respondsToSelector:sel]) {
        return [target methodSignatureForSelector:sel];
    } else {
        NSAssert(0, @"sel is nil or not exist this method or not register method!");
        return nil;
    }
}

- (id)fitterClass:(SEL)sel {
    //获取选择子方法名
    NSString *methodName = NSStringFromSelector(sel);
    pthread_mutex_lock(&_mutex);
    id target = [_classInfosMap objectForKey:methodName];
    pthread_mutex_unlock(&_mutex);
    return target;
}

- (id)executeMethod:(NSString *)methodName {
    NSAssert(methodName && methodName.length > 0, @"method name can't be blank");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL sel = NSSelectorFromString(methodName);
    return [self performSelector:sel];
#pragma clang diagnostic pop
}

- (id)executeMethods:(NSArray *)methodNames {
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    for (NSString *methodName in methodNames) {
        id param = [self executeMethod:methodName];
        if (param) [paramsDict setValue:param forKey:methodName];
    }
    return paramsDict.count > 0?paramsDict:nil;
}

- (id)executeMethod:(NSString *)methodName param:(id)param {
    NSAssert(methodName && methodName.length > 0, @"method name can't be blank");
    if (param && ![methodName hasSuffix:@":"]) {
        methodName = [methodName stringByAppendingString:@":"];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL sel = NSSelectorFromString(methodName);
    return [self performSelector:sel withObject:param];
#pragma clang diagnostic pop
}

- (id)executeMethod:(NSString *)methodName params:(NSArray<id> *)params {
    if (params.count == 0 || !params) {
        return [self executeMethod:methodName];
    }
    NSAssert(methodName && methodName.length > 0, @"method name can't be blanc");
    if (![methodName hasSuffix:@":"]) {
        methodName = [methodName stringByAppendingString:@":"];
    }
    // 方法签名(方法的描述)
    SEL sel = NSSelectorFromString(methodName);
    id target = [self fitterClass:sel];

    NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:sel];
    
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = sel;
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
    paramsCount = MIN(paramsCount, params.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = params[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i + 2];
    }
    // 调用方法
    [invocation invoke];
    
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}

- (void)dealloc {
    pthread_mutex_destroy(&_mutex);
}

@end
