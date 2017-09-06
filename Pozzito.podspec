#
#  Be sure to run `pod spec lint Pozzito.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "Pozzito"
  s.version      = "1.2.2"
  s.summary      = "Pozzito REST api SDK"
  s.description  = "Pozzito core, conversation and chat functionalities"
  s.homepage     = "https://github.com/pozzito-dev/pozzitoapi-ios"
  s.license      = "Private"
  s.author       = "Sedam IT"
  s.platform     = :ios, "9.0"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.1' }
  s.source       = { :git => 'https://github.com/pozzito-dev/pozzitoapi-ios.git', :tag => '1.2.2' }
  s.vendored_frameworks = 'Pozzito.framework'
end
