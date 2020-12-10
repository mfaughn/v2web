Bartelby.clear_cache(V2Plus::SegmentDefinition) && V2Plus::SegmentDefinition.save_sequel;
segs = V2Plus::SegmentDefinition.all;
sf = {}
segs.each do |seg|
  seg.fields.each do |f|
    if f.flag_string.length > 1
      next if f.flag_string =~ /R/
      sf[seg.code] ||= {}
      de = f.data_element
      if de.flags.length > 0
        puts "#{seg.code}-#{f.sequence_number}: #{f.flag_string}"
        puts "    #{de.item_number}; #{de.flags}; #{de.data_type&.code}"
      end      
      sf[seg.code][f.sequence_number] = "#{f.flags}; #{f.flag_string}; #{de.item_number}; #{de.flags}; #{de.data_type&.code}"
    end
  end
end
# pp sf