folder = V2Pub.xsd_dir
xsds   = Dir[File.join(V2Pub.xsd_dir, '*.xsd')]
xsds.each do |xsd|
  system "tidy -xml -indent -quiet -utf8 -o #{xsd} #{xsd}"
end