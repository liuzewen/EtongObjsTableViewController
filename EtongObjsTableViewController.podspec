
Pod::Spec.new do |s|
  s.name             = "EtongObjsTableViewController"
  s.version          = "0.0.2"
  s.summary          = "EtongObjsTableViewController is used on iOS."
  s.description      = <<-DESC
                       It is a marquee view used on iOS, which implement by Objective-C.
                       DESC
  s.homepage         = "https://github.com/liuzewen/EtongObjsTableViewController"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "liuzewen" => "s1224w106@gmail.com" }
  s.source           = { :git => "https://github.com/liuzewen/EtongObjsTableViewController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/NAME'

  s.platform     = :ios, '7.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'EtongObjsTableViewController/*'
  # s.resources = 'Assets'

  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'
  s.dependency 'MJRefresh'
end
