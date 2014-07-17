Pod::Spec.new do |s|
  s.name             = "AFView"
  s.version          = "0.1.0"
  s.summary          = "A view composition and layout framework for iOS."
  s.description      = <<-DESC
                       A view composition and layout framework for iOS, supporting nibs when they're useful and code when they're not.
                       DESC
  s.homepage         = "https://github.com/mlatham/AFView"
  s.license          = 'MIT'
  s.author           = { "Matt Latham" => "matt.e.latham@gmail.com" }
  s.source           = { :git => "https://github.com/mlatham/AFView.git", :tag => 'v0.1.0' }
  s.social_media_url = 'https://twitter.com/mattlath'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'AFView', 'AFView/**
  s.resources = 'Pod/Assets/*.png'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
