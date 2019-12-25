#
# Be sure to run `pod lib lint XBSwiftLayoutKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XBSwiftCategoryKit'
  s.version          = '0.0.1'
  s.summary          = 'Swift扩展组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 扩展组件，主要集合各种扩展
                       DESC

  s.homepage         = 'https://github.com/Xinboy/XBSwiftCategoryKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Xinboy' => 'xinbo.hong@hotmail.com' }
  s.source           = { :git => 'git@github.com:Xinboy/XBSwiftCategoryKit.git', :tag => s.version.to_s }

  s.platform    = :ios, "8.0"
  s.ios.deployment_target = '8.0'

  s.source_files = 'XBSwiftCategoryKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XBSwiftLayoutKit' => ['XBSwiftCategoryKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  
  	s.frameworks = 'UIKit', 'Foundation'
	s.dependency 'SnapKit'
end

