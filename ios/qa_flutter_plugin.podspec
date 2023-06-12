#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint qa_flutter_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'qa_flutter_plugin'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for QA SDK'
  s.description      = <<-DESC
A new Flutter plugin
                       DESC
  s.homepage         = 'https://quantactions.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Quantactions' => 'support@quantactions.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
