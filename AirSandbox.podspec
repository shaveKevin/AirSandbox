Pod::Spec.new do |s|
  s.name         = "AirSandbox"
  s.version      = "0.0.1"
  s.summary      = "ios developer  AirSandbox"
  s.description  = <<-DESC
                   AirSandbox
                   AirSandbox
                   DESC
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = "https://github.com/shaveKevin/AirSandbox"
  s.authors      = { 'shavekevin' => 'shavekevin@gmail.com' }
  s.social_media_url   = "http://www.shavekevin.com"
  s.platform     = :ios,"7.0"
  s.requires_arc = true
  s.source_files = 'AirSandbox/**/*.{h,m}'
  s.public_header_files = 'AirSandbox/**/*.{h}'
  s.source       = { :git => "https://github.com/shaveKevin/AirSandbox.git", :tag => "0.0.1" }
  s.frameworks = 'UIKit'
end
