//
//  YHProxyRouter.h
//  YHMultipleInheritance
//
//  Created by apple on 2017/11/3.
//  Copyright © 2017年 玉河川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHProxyRouter : NSProxy

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
  PerformSelector single selector without params
  @param methodName method name (NSString *)
 */
- (id)executeMethod:(NSString *)methodName;

/**
 PerformSelector multiple selectors without params
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
