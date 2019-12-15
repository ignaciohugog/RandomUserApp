# sources
source 'https://github.com/CocoaPods/Specs.git'

# global
platform :ios, '10.0'
use_frameworks!
workspace 'RandomUserApp'

def commonPods
  pod 'Alamofire', '~> 5.0.0-rc.2'
  pod 'PromiseKit', '~> 6.8'
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

