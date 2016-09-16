Pod::Spec.new do |s|
  s.name             = 'AlamofireURLRequestConfigurable'
  s.version          = '1.1'
  s.summary          = 'URLRequestConfigurable for Alamofire - Even cleaner type safe routing'
  s.description      = <<-DESC
A replacement for Alamofire's URLRequestConvertible protocol for even cleaner type safe routing.
                       DESC
  s.homepage         = 'https://github.com/gmarm/AlamofireURLRequestConfigurable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'George Marmaridis' => 'gmarmas@gmail.com' }
  s.source           = { :git => 'https://github.com/gmarm/AlamofireURLRequestConfigurable.git', :tag => '1.1' }
  s.social_media_url = 'https://twitter.com/gmarm'
  s.ios.deployment_target = '9.0'
  s.source_files = 'AlamofireURLRequestConfigurable/Classes/**/*'
  s.dependency 'Alamofire', '~> 4.0'
end
