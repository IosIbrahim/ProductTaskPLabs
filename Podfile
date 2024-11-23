# Uncomment the next line to define a global platform for your project
#platform :ios, '9.0'

target 'Agent' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Agent
  pod 'R.swift' , '~> 6.1.0'
  pod 'Alamofire', '4.8.0'
  pod 'Cosmos'
  pod 'ReachabilitySwift', '4.3.1'
  pod 'RevealingSplashView', '~> 0.6'
  pod 'SideMenu', '~> 6.0'
  pod 'Kingfisher'
  pod "ImageSlideshow/SDWebImage"
  pod 'Hero'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Messaging'
  pod 'Firebase/Storage'
  pod 'NVActivityIndicatorView', '~> 4.6'
  pod 'FSCalendar'
  pod 'Charts'

  post_install do |installer|
      installer.generated_projects.each do |project|
            project.targets.each do |target|
                target.build_configurations.each do |config|
                    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
                    
                    target.build_configurations.each do |config|
                      xcconfig_path = config.base_configuration_reference.real_path
                      xcconfig = File.read(xcconfig_path)
                      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
                      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
                    end
                 end
            end
     end
end
end


