#
# Be sure to run `pod lib lint HapticGenerator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HapticGenerator'
  s.version          = '1.0.0'
  s.summary          = 'Easy peasy haptic generation on iOS.'
  s.description      = <<-DESC
  Apple's UIFeedbackGenerator subclasses are not difficult to use, but they are messy.
  HapticGenerator tidies this up and makes the process of creating different types of haptics on iOS easy and coherent.
                       DESC
  s.homepage         = 'https://github.com/kanecheshire/HapticGenerator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kanecheshire' => 'kane.cheshire@googlemail.com' }
  s.source           = { :git => 'https://github.com/kanecheshire/HapticGenerator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kanecheshire'
  s.ios.deployment_target = '8.0'
  s.source_files = 'HapticGenerator/Classes/**/*', 'HapticGenerator.swift'
end
