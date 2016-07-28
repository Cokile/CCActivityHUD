Pod::Spec.new do |spec|
  spec.name                  = 'CCActivityHUD'
  spec.platform              = :ios
  spec.version               = '2.1.6'
  spec.license               = { :type => 'MIT' }
  spec.homepage              = 'https://github.com/Cokile/CCActivityHUD'
  spec.authors               = { 'Cokile' => 'kelvintgx@gmail.com' }
  spec.summary               = 'A simple replacement for UIActivityIndicatorView'
  spec.source                = {:git => 'https://github.com/Cokile/CCActivityHUD.git', :tag => 'v2.1.6'}
  spec.source_files          = 'CCActivityHUD/*.{h,m}'
  spec.resources             = 'CCActivityHUD/*.png'
  spec.requires_arc          = true
end
