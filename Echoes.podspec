Pod::Spec.new do |s|
	      s.name     = 'Echoes'
	      s.version  = '0.0.1'
	      s.platform = :ios, '5.0'
	      s.platform = :osx, '10.7'
	      s.license  = 'MIT'
	      s.summary  = 'Echoes.'
	      s.homepage = 'https://github.com/bananita/Echoes'
	      s.author   = { 'Michał Banasiak' => 'm.banasiak@icloud.com' }
	      s.source   = { :git => 'https://github.com/bananita/Echoes.git', :tag => s.version.to_s }
	   

	      s.description = 'EChoes.'

	      s.source_files = 'Echoes/	*.{h,m,c}'
	      s.requires_arc = true
end	