Pod::Spec.new do |s|
  s.name             = 'KeccakSwift'
  s.version          = '1.0.0'
  s.summary          = 'Swift wrapper for KeccakC library'
  s.homepage         = 'https://github.com/sublabdev/keccak-swift'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'Substrate Laboratory LLC' => 'info@sublab.dev' }
  s.source           = { :git => 'https://github.com/sublabdev/keccak-swift.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.source_files = 'Sources/KeccakSwift/**/*'
  s.dependency 'KeccakC', '1.0.0'
end
