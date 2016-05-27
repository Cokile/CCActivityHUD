Pod::Spec.new do |spec|
  spec.name             = 'CCActivityIndicatorView'
  spec.platform         = :ios
  spec.ios.deployment_target = '8.0'
  spec.version          = '1.1.0'
  spec.license          = { :type => 'MIT' }
  spec.homepage         = 'https://github.com/Cokile/CCActivityIndicatorView'
  spec.authors          = { 'Cokile' => 'kelvintgx@gmail.com' }
  spec.summary          = 'A simple replacement for UIActivityIndicatorView.'
  spec.source           = { :git => 'https://github.com/Cokile/CCActivityIndicatorView.git', :tag => 'v1.1.0' }
  spec.source_files     = 'CCActivityIndicatorView/*'
  spec.requires_arc     = true
end
