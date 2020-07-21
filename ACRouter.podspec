Pod::Spec.new do |spec|

  spec.name          = "ACRouter"
  spec.version       = "0.0.1"
  spec.summary       = "一个便捷的Swift版本Swift&OC通用的轻量的路由工具"
  spec.homepage      = "https://github.com/aosic/Router"
  spec.license       = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author        = { "aosic" => "724315346@qq.com" }
  spec.source        = { :git => "https://github.com/aosic/Router.git", :tag => "#{spec.version}" }

  spec.frameworks    = 'UIKit', 'Foundation'
  spec.swift_version = "5.0"
  spec.requires_arc  = true
  spec.source_files  = "Sources/**/*.swift"

  spec.ios.deployment_target = '10.0'
end
