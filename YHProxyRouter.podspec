Pod::Spec.new do |s|

  s.name         = "YHProxyRouter"
  s.version      = "1.0.1"
  s.summary      = "A tool to realize multiple inheritance! Support: http://www.jianshu.com/u/7c43d8cb3cff"
  s.homepage     = "https://github.com/yuhechuan/YHProxyRouter"
  s.license      = "MIT"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/yuhechuan/YHProxyRouter.git", :tag => s.version }
  s.source_files = "sources/**/*.{h,m}"
  s.requires_arc = true

  s.author       = { "yuhechuan" => "yuhechuan@ruaho.com" }

end