
Pod::Spec.new do |s|
  s.name             = 'SHVideoPlayer'
  s.version          = '0.1.0'
  s.summary          = 'A wrapper library around AVPlayer to customize AVPlayerLayer with custom controls.'
  s.description      = <<-DESC
A wrapper library around AVPlayer to customize AVPlayerLayer with custom controls using protocol to create your own customized layer.
                       DESC

  s.homepage         = 'https://github.com/shabib87/SHVideoPlayer.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ahmad Shabibul Hossain' => 'shabib.sust@gmail.com' }
  s.source           = { :git => 'https://github.com/shabib87/SHVideoPlayer.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/shabib_hossain'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SHVideoPlayer/Classes/**/*'

  s.resource_bundles = {
    'SHVideoPlayer' => ['SHVideoPlayer/Assets/*.png']
  }

  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'SnapKit', '~> 3.0'
end
