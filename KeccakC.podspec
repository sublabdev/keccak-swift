Pod::Spec.new do |s|
  s.name             = 'KeccakC'
  s.version          = '1.0.0'
  s.summary          = 'Keccak C wrapper for CocoaPods'
  s.homepage         = 'https://github.com/sublabdev/keccak-swift'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'Substrate Laboratory LLC' => 'info@sublab.dev' }
  s.source           = { :git => 'https://github.com/sublabdev/keccak-swift.git', :tag => 'c-' + s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.source_files = 'Sources/KeccakC/**/*.{c,h}'
  s.public_header_files = 'Sources/KeccakC/include/*.h'
  s.pod_target_xcconfig = {
    'OTHER_CFLAGS' => '-pedantic -Wall -Wextra -Wcast-align -Wnested-externs -Wshadow -Wstrict-prototypes -Wno-shorten-64-to-32 -Wno-conditional-uninitialized -Wno-unused-function -Wno-long-long -Wno-overlength-strings -O3',
    'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/KeccakC"'
  }
  s.module_name = 'KeccakC'
end
