# RN Resolve react_native_pods.rb with node to allow for hoisting
require Pod::Executable.execute_command('node', ['-p',
  'require.resolve(
    "react-native/scripts/react_native_pods.rb",
    {paths: [process.argv[1]]},
  )', __dir__]).strip

platform :ios, min_ios_version_supported


# flipper_config = ENV['NO_FLIPPER'] == "1" ? FlipperConfiguration.disabled : FlipperConfiguration.enabled
# linkage = ENV['USE_FRAMEWORKS']
# if linkage != nil
#   Pod::UI.puts "Configuring Pod with #{linkage}ally linked Frameworks".green
#   use_frameworks! :linkage => linkage.to_sym
# end



# Flutter
flutter_application_path = '../yhec_flutter'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')



target 'ios' do
  use_frameworks!
  # Flutter
  install_all_flutter_pods(flutter_application_path)
  
  
  post_install do |installer|
    # Flutter
    flutter_post_install(installer) if defined?(flutter_post_install)
  end

  # 解决 [!] The 'Pods-ios' target has transitive dependencies that include statically linked binaries: (Flipper-Boost-iOSX)
  # pre_install do |installer|
  #   Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
  # end
  

  pod 'React', :path => '../node_modules/react-native', :subspecs => [
    'Core',
    'CxxBridge', # 如果RN版本 >= 0.47则加入此行
    'DevSupport', # 如果RN版本 >= 0.43，则需要加入此行才能开启开发者菜单
    'RCTImage',
    'RCTText',
    'RCTNetwork',
    'RCTWebSocket', # 调试功能需要此模块
    'RCTAnimation', # FlatList和原生动画功能需要此模块
    'RCTActionSheet',
    'RCTGeolocation',
    'RCTPushNotification',
    'RCTSettings',
    'RCTVibration',
    'RCTLinkingIOS'
    ]


    # pods
    pod 'AFNetworking'
    pod 'SnapKit'
    #新增部分
    # 如果你的RN版本 >= 0.42.0，则加入下面这行，注意path路径
    pod "Yoga", :path => "../node_modules/react-native/ReactCommon/yoga/Yoga.podspec"
    
    #新增部分
    # 如果RN版本 >= 0.45则加入下面三个第三方编译依赖，注意podspec路径
    pod 'DoubleConversion', :podspec => '../node_modules/react-native/third-party-podspecs/DoubleConversion.podspec'
    pod 'glog', :podspec => '../node_modules/react-native/third-party-podspecs/glog.podspec'
    pod 'RCT-Folly', :podspec => '../node_modules/react-native/third-party-podspecs/RCT-Folly.podspec'
      

end






