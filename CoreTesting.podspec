#
# Be sure to run `pod lib lint CoreTesting.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CoreTesting'
  s.version          = '0.1.6'
  s.summary          = 'Testing framework that includes helpers and utils for writing iOS tests.'
  
  if s.respond_to?(:swift_versions) then
    s.swift_versions = ['5.0']
  else
    s.swift_version  = '5.0'
  end
  
  s.platform         = :ios, "10.0"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Testing framework that includes helpers and utils for writing iOS tests.
Includes strategies for snapshot testing the view and layout tests.
                       DESC

  s.homepage         = 'https://github.com/trading-point/core-testing.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gsoti' => 'ge.sotiropoulos@gmail.com' }
  s.source           = { :git => 'https://github.com/trading-point/core-testing.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'CoreTesting/Classes/**/*.swift'
  
  s.dependency 'SnapshotTesting', '~> 1.7.2'
  s.dependency 'LayoutTest/Swift', '~> 6.0.1'
    
  s.frameworks = "XCTest"
  
  s.pod_target_xcconfig = {
#    'APPLICATION_EXTENSION_API_ONLY' => 'YES',
#    'DEFINES_MODULE' => 'YES',
    'ENABLE_BITCODE' => 'NO',
    'OTHER_LDFLAGS' => '$(inherited) -weak-lXCTestSwiftSupport -Xlinker -no_application_extension',
#    'OTHER_SWIFT_FLAGS' => '$(inherited) -suppress-warnings',
    'LIBRARY_SEARCH_PATHS' => '$(inherited) "$(PLATFORM_DIR)/Developer/usr/lib"',
  }
end
