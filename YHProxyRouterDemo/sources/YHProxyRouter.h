//
//  YHProxyRouter.h
//  YHProxyRouterDemo
//
//  Created by apple on 2017/11/3.
//  Copyright © 2017年 玉河川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHProxySingleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHProxyRouter : NSProxy

SINGLETON_FOR_HEADER(YHProxyRouter);

/**
 targets array: Class name of sting
 */

@property (nonatomic, strong,readwrite) NSArray *targets;

/**
 Creates and returns a YHProxyRouter object with targets.
 
 @param targets Class name of sting.
 
 @return A new YHProxyRouter .
 */
+ (instancetype)initWithTargets:(NSArray <NSString *>*)targets;

/**
 register single target with params
 @param targetName targetName (NSString *)
 */
- (void)registerTargetName:(NSString *)targetName;

/**
 unregister single target  params
 @param targetName targetName (NSString *)
 */
- (void)unregisterTargetName:(NSString *)targetName;

/**
 unregister all target without params
 */
- (void)unregisterAllTarget;

/**
  PerformSelector single selector with params
  @param methodName method name (NSString *)
 */
- (id)executeMethod:(NSString *)methodName;

/**
 PerformSelector multiple selectors with params
 @param methodNames method name (NSArray <NSString *>*)
 */
- (id)executeMethods:(NSArray *)methodNames;

/**
 PerformSelector single selector has one params
 @param methodName method name (NSString *)
 @param param 入参(id)
 */
- (id)executeMethod:(NSString *)methodName param:(id)param;

/**
 PerformSelector single selector has more params
 @param methodName method name (NSString *)
 @param params 入参(NSArray<id> *)
 */
- (id)executeMethod:(NSString *)methodName params:(NSArray<id> *)params;

@end

NS_ASSUME_NONNULL_END
