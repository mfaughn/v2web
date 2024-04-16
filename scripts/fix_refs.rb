refs = V2Web::Reference.all;
# types = refs.map { |r| r.ref_class.to_s }.uniq.sort
# puts types
refs.each do |r|
  rc = r.ref_class
  next unless rc
  ChangeTracker.start
  r.ref_class = rc.sub('HL7::', 'HL7::V2::')
  r.save
  ChangeTracker.commit
end
