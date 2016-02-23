workspace 'AFView'

xcodeproj 'AFView.xcodeproj', 'Debug' => :debug, 'Release' => :release

target 'AFViewExample' do
	xcodeproj 'AFViewExample.xcodeproj', 'Debug' => :debug, 'Release' => :release

	platform :ios, '8.0'
	
	use_frameworks!
	
	pod 'AFView', :path => '.'
end

target 'AFView' do
	xcodeproj 'AFView.xcodeproj', 'Debug' => :debug, 'Release' => :release

	platform :ios, '8.0'
end
