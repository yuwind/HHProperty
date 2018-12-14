Pod::Spec.new do |s|
  s.name         = "HHProperty"    #存储库名称
  s.version      = "1.0.0"      #版本号，与tag值一致
  s.summary      = "Generate model properties quickly."  #简介
  s.homepage     = "https://github.com/yuwind/HHProperty/wiki"
  s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
  s.author       = { "豫风" => "991810133@qq.com" }  #作者
  s.platform     = :ios, "7.0"                  #支持的平台和版本号
  s.source       = { :git => "https://github.com/yuwind/HHProperty.git", :tag => "1.0.0" }         #存储库的git地址，以及tag值
  s.source_files  =  "HHProperty/*.{h,m}" #需要托管的源代码路径
  s.requires_arc = true #是否支持ARC

end
