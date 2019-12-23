# sources
source 'https://github.com/CocoaPods/Specs.git'

# global
platform :ios, '10.0'
use_frameworks!
workspace 'RandomUserApp'

def commonPods
  pod 'RxSwift', '~> 5'
  pod 'Alamofire', '~> 5.0.0-rc.2'
end

def uiPods
  pod 'Kingfisher', '~> 5.0'  
end

target 'RandomUserApp' do
  commonPods
  uiPods
  target 'RandomUserAppTests' do
  end
end

target 'Core' do
  project './Core/Core'
  commonPods
  target 'CoreTests' do
  end
end

