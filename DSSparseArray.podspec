Pod::Spec.new do |s|
  s.name = "DSSparseArray"
  s.version = "1.5.1"
  s.author = { "David W. Stockton" => "stockton@syntonicity.com" }
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.source = { :git => "https://github.com/LavaSlider/DSSparseArray.git", :tag => "v1.5.1" }
  s.summary = "Objective C Sparse Array Implementation"
  s.homepage = "https://github.com/LavaSlider/DSSparseArray"
  s.source_files = 'DSSparseArray/DSSparseArray*.{h,m}'
  s.platform = :osx
  s.requires_arc = true
end
