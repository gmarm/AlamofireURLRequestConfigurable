Pod::Spec.new do |s|
  s.name             = 'AlamofireURLRequestConfigurable'
  s.version          = '1.0'
  s.summary          = 'A short description of AlamofireURLRequestConfigurable.'
  s.description      = <<-DESC
A replacement for Alamofire's URLRequestConvertible for even cleaner and flexible type safe routing.
                       DESC
  s.homepage         = 'https://github.com/gmarm/AlamofireURLRequestConfigurable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'George Marmaridis' => 'gmarmas@gmail.com' }
  s.source           = { :git => 'https://github.com/gmarm/AlamofireURLRequestConfigurable.git', :tag => '1.0' }
  s.social_media_url = 'https://twitter.com/gmarm'
  s.ios.deployment_target = '8.0'
  s.source_files = 'AlamofireURLRequestConfigurable/Classes/**/*'
  s.dependency 'Alamofire', '~> 3.0'
end
