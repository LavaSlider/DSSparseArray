Pod::Spec.new do |s|
  s.name = "DSSparseArray"
  s.version = "1.2.1"
  s.author = { "David W. Stockton" => "stockton@syntonicity.net" }
  s.license = 'MIT'
  s.source = { :git => "https://github.com/LavaSlider/DSSparseArray.git", :tag => "1.0.0" }
  s.summary = "Objective C Sparse Array Implementation"
  s.homepage = "https://github.com/LavaSlider/DSSparseArray"
  s.source_files = 'DSSparseArray/*.{h,m}'
  s.requires_arc = true
end
