Pod::Spec.new do |s|
  s.name         = 'HHProperty' 
  s.version      = '1.0.0'
  s.summary      = 'Generate model properties quickly.'
  s.homepage     = 'https://github.com/yuwind/HHProperty/wiki'
  s.license      = 'MIT'
  s.author       = { 'yuwind' => '991810133@qq.com' }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/yuwind/HHProperty.git", :tag => s.version}
  s.source_files = 'HHProperty/*.{h,m}'
  s.requires_arc = true

end
