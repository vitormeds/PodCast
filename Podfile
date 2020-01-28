# Uncomment the next line to define a global platform for your project
platform :ios, '13.2'

inhibit_all_warnings!

def shared_pods
  pod 'R.swift'
end

target 'PodCast' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  shared_pods
  
  pod 'FRadioPlayer'
  pod 'Nuke'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'lottie-ios'
  pod 'MarqueeLabel'
  pod 'RAMAnimatedTabBarController'
  pod 'Firebase/Core'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'Google-Mobile-Ads-SDK'
  pod 'Firebase/AdMob'
  pod 'Fabric'
  pod 'Crashlytics'

  # Pods for PodCast

  target 'PodCastTests' do
    inherit! :search_paths
    # Pods for testing
  end
end

target 'PodCastUITests' do
  inherit! :search_paths
  shared_pods
end
