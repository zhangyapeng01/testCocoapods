

Pod::Spec.new do |s|

  s.name         = "test"
  s.version      = "0.0.1"
  s.summary      = "test 私有pod测试项目"
  s.homepage     = "https://github.com/zhangyapeng01/testCocoapodsTestProject.git"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "zhangyapeng" => "1365160860@qq.com" }
  s.platform     = :ios, "8.0"

  s.source = { :git => "https://github.com/zhangyapeng01/testCocoapodsTestProject.git", :tag => "#{s.version}" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "test","test/Masonry/*.{h,m}"

  s.requires_arc = true

end
