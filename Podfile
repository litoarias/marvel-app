platform :ios, '11.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'MarvelApp' do
	use_frameworks!
	
	pod 'Alamofire'
	pod 'PromiseKit/CorePromise'
	pod 'Sourcery'
	pod 'PagedLists', :git => 'https://github.com/litoarias/PagedLists'

	
	post_install do |pi|
		pi.pods_project.targets.each do |t|
			t.build_configurations.each do |config|
				config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
			end
		end
	end
	
end
