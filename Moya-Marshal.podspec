Pod::Spec.new do |s|
  s.name             = 'Moya-Marshal'
  s.version          = '1.0.0'
  s.summary          = 'Marshal mappings for Moya network requests'
  s.description  = <<-EOS
  [Marshal](https://github.com/utahiosmac/Marshal) bindings for
  [Moya](https://github.com/Moya/Moya) for easier JSON serialization.
  Includes [RxSwift](https://github.com/ReactiveX/RxSwift/) and 
  [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa/) bindings as well.
  Instructions on how to use it are in
  [the README](https://github.com/JARMourato/Moya-Marshal).
  EOS

  s.homepage         = 'https://github.com/JARMourato/Moya-Marshal'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JARMourato' => 'joao.armourato@gmail.com' }
  s.source           = { :git => 'https://github.com/JARMourato/Moya-Marshal.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/_JARMourato'

  s.osx.deployment_target    = '10.9'
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/*.swift"
    ss.dependency "Moya", "~> 8.0.0"
    ss.dependency "Marshal", "~> 1.2.0"
    ss.framework  = "Foundation"
  end

  s.subspec "RxSwift" do |ss|
    ss.source_files = "Sources/RxSwift/*.swift"
    ss.dependency "Moya/RxSwift"
    ss.dependency "Moya-Marshal/Core"
  end

  s.subspec "ReactiveCocoa" do |ss|
    ss.source_files = "Sources/ReactiveCocoa/*.swift"
    ss.dependency "Moya/ReactiveCocoa"
    ss.dependency "Moya-Marshal/Core"
  end

end
