

Pod::Spec.new do |s|

  s.name         = "CrashTool"
  s.version      = "0.1.1"
  s.summary      = "A avoid crash tool for iOS."
  s.homepage     = "https://github.com/GDAwen/CrashTool"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Andrew" => "h20121028@126.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/GDAwen/CrashTool.git", :tag => s.version.to_s }
  s.source_files  = "CrashTool/*"

  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true



end
