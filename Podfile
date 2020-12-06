platform :ios, '11.0'

# ignore all warnings from all pods
inhibit_all_warnings!
xcodeproj 'MarvelApp.xcodeproj', 'xctest' => :debug
install! 'cocoapods', :deterministic_uuids => false

target 'MarvelApp' do
	use_frameworks!
	
	pod 'Alamofire'
	pod 'PromiseKit/CorePromise'
	pod 'Sourcery'
	pod 'PagedLists', :git => 'https://github.com/litoarias/PagedLists'
	
	target 'MarvelAppTests' do
		inherit! :search_paths
		use_frameworks!

	end
	
	post_install do |pi|
		pi.pods_project.targets.each do |t|
			t.build_configurations.each do |config|
				config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
			end
		end
	end
	
end
