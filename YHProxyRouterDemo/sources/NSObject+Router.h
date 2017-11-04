//
//  NSObject+Router.h
//  YHMultipleInheritance
//
//  Created by apple on 2017/11/4.
//  Copyright © 2017年 玉河川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHProxyRouter.h"

/**
 Category that adds built-in `YHProxyRouter`on any instance of `NSObject`.
 This makes it convenient to simply create and forget a `YHProxyRouter`
 */

@interface NSObject (Router)

/**
 @abstract Lazy-loaded YHProxyRouter for use with any object
 @return YHProxyRouter associated with this object, creating one if necessary
 */
@property (nonatomic, strong) YHProxyRouter *proxyRouter;

@end
