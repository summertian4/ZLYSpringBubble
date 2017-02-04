#
#  Be sure to run `pod spec lint ZLYSpringBubble.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "ZLYSpringBubble"
  s.version      = "0.1.0"
  s.summary      = "ZLYSpringBubble 是一个仿 QQ 未读消息拖拽气泡的工具"
  s.homepage     = "https://github.com/summertian4/ZLYSpringBubble"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "周凌宇" => "coderfish@qq.com" }
  # Or just: s.author    = "周凌宇"
  # s.authors            = { "周凌宇" => "coderfish@qq.com" }
  # s.social_media_url   = "http://twitter.com/周凌宇"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.ios.deployment_target = "7.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/summertian4/ZLYSpringBubble.git", :tag => s.version.to_s }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.exclude_files = "ZLYSpringBubble/ZLYSpringBubble/ZLYSpringBubble*.{h,m}"

  # s.public_header_files = "Classes/**/*.h"

end
