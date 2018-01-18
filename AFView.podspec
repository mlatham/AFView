Pod::Spec.new do |s|
  s.name				= "AFView"
  s.version				= "0.1.0"
  s.summary				= "A view composition and layout framework for iOS."
  s.description			= <<-DESC
						  A view composition and layout framework for iOS, supporting nibs when they're useful and code when they're not.
						  DESC
  s.homepage			= "https://github.com/mlatham/AFView"
  s.license				= "WTFPL"
  s.author				= { "Matt Latham" => "matt.e.latham@gmail.com" }
  s.social_media_url	= "https://twitter.com/mattlath"
  
  s.source				= { :git => "https://github.com/mlatham/AFView.git", :tag => "v0.1.0" }
  s.source_files		= 'AFView/Pod/**/*.{h,m}'
  s.public_header_files = 'AFView/Pod/**/*.h'
  
  s.prefix_header_contents = '#import "AFView-Includes.h"'

  s.platform			= :ios, "10.0"
  s.requires_arc		= true

end
