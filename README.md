# YHProxyRouter

[![Travis](https://img.shields.io/travis/yuhechuan/YHProxyRouter.svg)](https://travis-ci.org/yuhechuan/YHProxyRouter)
[![CocoaPods](https://img.shields.io/cocoapods/v/YHProxyRouter.svg)](http://cocoadocs.org/docsets/YHProxyRouter)
[![CocoaPods](https://img.shields.io/cocoapods/l/YHProxyRouter.svg)](https://raw.githubusercontent.com/iTofu/YHProxyRouter/master/LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/p/YHProxyRouter.svg)](http://cocoadocs.org/docsets/YHProxyRouter)
[![Laguage](https://img.shields.io/badge/language-ObjC%20%26%20Swift-orange.svg)](https://github.com/yuhechuan/YHProxyRouter)
[![CocoaPods](https://img.shields.io/cocoapods/dt/YHProxyRouter.svg)](https://cocoapods.org/pods/YHProxyRouter)
[![简书](https://img.shields.io/badge/blog-简书-brightgreen.svg)](http://www.jianshu.com/u/7c43d8cb3cff)
[![GitHub stars](https://img.shields.io/github/stars/yuhechuan/YHProxyRouter.svg?style=social&label=Star)](https://github.com/yuhechuan/YHProxyRouter)

☀️一个用Object-C 写的实现多继承, 而且解耦功能强大的工具。

```
May you spend your life in the way you like,this sentence is so beautiful.

"愿你以自己喜欢的方式度过一生"，这句话太美了。
```

欢迎访问我的简书：http://www.jianshu.com/u/7c43d8cb3cff

## 目录 Contents

* [环境 Requirements](#环境-requirements)
* [介绍 Introduction](#介绍-introduction)
* [使用 Usage](#使用-usage)
* [版本 ChangeLog](#版本-changelog)
* [提示 Tips](#提示-tips)
* [鸣谢 Thanks](#鸣谢-thanks)
* [联系 Support](#联系-support)
* [许可 License](#许可-license)



## 环境 Requirements

* iOS 7.0+
* Xcode 7.0+
* Objective-C


## 介绍 Introduction

☀️ 一个用Object-C 写的实现多继承, 而且解耦功能强大的工具。

* iOS 7.0 +，Demo 需要 xcode 9.0+环境运行。

* 通过NSProxy作为中间代理,通过消息转发的形式,实现多个类方法的统一调度,变相实现多继承。

* 注册类和反方调用都是通过传入字符串形式,不需要导入头文件, 基本实现解耦功能。

* 有两种调用方式, 一种是通过直接创建,第二种通过类别给NSObject添加属性,直接可用点语法创建,传入注册类。

> 💬 **告示**
>
>  欢迎大家使用,有问题请及时联系我.
>
> 直接 [PR](https://github.com/yuhechuan/YHProxyRouter/pulls) 或者发我邮箱 `yuhechuan@ruaho.com` 都可！




## 使用 Usage

* 两种导入方法：

* 方法一：[CocoaPods](https://cocoapods.org/)：`pod 'YHProxyRouter'`

* 方法二：直接把 sources 文件夹（在 Demo 中）拖拽到你的项目中

* 在相应位置导入头文件：`#import "YHProxy.h"`

* 使用下列任意方法都可以：
 1. 直接创建，初始化 `YHProxyRouter`对象.
```
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
```
 2. 直接调用 `self.proxyRouter`生成对象.
 ```
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
 ```
 
 ## 版本 ChangeLog
 
 ### [V 1.0.0](https://github.com/yuhechuan/YHProxyRouter/releases/tag/1.0.0) (2017.11.04)
 * 首次提交!
 
 ## 提示 Tips
 
  * `self.proxyRouter`和`initWithTargets:` 不能传入`nil`,否则会崩溃到断言`NSAssert`。
  
  * 入参时 ,方法名中的`:` ,如果在字符串最后可以省略,如果在中间不可省略。


 ## 鸣谢 Thanks
 
 * [YYKit](https://github.com/ibireme/YYKit)
 
 * 海纳百川，有容乃大。感谢开源社区和众攻城狮的支持！感谢众多 [Issues](https://github.com/yuhechuan/YHProxyRouter/issues) 和 [PR](https://github.com/yuhechuan/YHProxyRouter/pulls)！更期待你的 [PR](https://github.com/yuhechuan/YHProxyRouter/pulls)！
 
 
 
 ## 联系 Support
 
 * 有疑问或建议请 [New Issue](https://github.com/yuhechuan/YHProxyRouter/issues/new)，谢谢 :)
 
 * Mail: `yuhechuan@ruaho.com`
 
 * 简书: http://www.jianshu.com/u/7c43d8cb3cff

 
 ## 许可 License
 
 YHProxyRouter is released under the [MIT License](https://github.com/yuhechuan/YHProxyRouter/blob/master/LICENSE).
 
 
 


