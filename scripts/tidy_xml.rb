folder = V2Plus.xsd_dir
xsds   = Dir[File.join(V2Plus.xsd_dir, '*.xsd')]
xsds.each do |xsd|
  system "tidy -xml -indent -quiet -utf8 -o #{xsd} #{xsd}"
end