Pod::Spec.new do |s|
  s.name             = 'AlamofireURLRequestConfigurable'
  s.version          = '1.2'
  s.summary          = 'URLRequestConfigurable for Alamofire - Even cleaner type safe routing'
  s.description      = <<-DESC
A replacement for Alamofire's URLRequestConvertible protocol for even cleaner type safe routing.
                       DESC
  s.homepage         = 'https://github.com/gmarm/AlamofireURLRequestConfigurable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'George Marmaridis' => 'gmarmas@gmail.com' }
  s.source           = { :git => 'https://github.com/gmarm/AlamofireURLRequestConfigurable.git', :tag => '1.2' }
  s.social_media_url = 'https://twitter.com/gmarm'
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'
  s.swift_versions = ['5.0', '5.1']
  s.source_files = 'AlamofireURLRequestConfigurable/Classes/**/*'
  s.dependency 'Alamofire', '~> 4.0'
end
