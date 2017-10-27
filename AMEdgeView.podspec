Pod::Spec.new do |s|
  s.name             = "AMEdgeView"
  s.version          = "0.2.1"
  s.summary          = "A `UIView` subclass that can be used as a border added to another view on one edge."

  s.homepage         = "https://github.com/AnthonyMDev/AMEdgeView"
  s.license          = 'MIT'
  s.author           = { "Anthony Miller" => "AnthonyMDev@gmail.com" }
  s.source           = { :git => "https://github.com/AnthonyMDev/AMEdgeView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AnthonyMDev'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.frameworks = 'UIKit'
end
