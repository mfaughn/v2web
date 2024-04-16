# example_file = File.expand_path('~/projects/v2web/igamt/hl7-data/segment.json')
# show_example(example_file)
def igamt_seg
  json = []
  V2::SegmentDefinition.sort_by { |seg| seg.code }.each do |seg|
    next if seg.code == '...'
    fields = []
    seg.fields.each do |f|
      # puts f.class.properties.keys.sort
      # pp f
      # raise
      unless (f.sequence_number == (f.segment_definition_position + 1))
      
        raise "#{seg.code}.#{f.sequence_number} has a problem because it's order number is #{f.segment_definition_position}"
      end
      usage = f.optionality.value
      # if usage == 'W'
      #   pp f
      #   raise
      # end
      f_dt = usage == 'W' ? '-' : f.type_code
      # if comp_dt.nil? && is_primitive
      #   comp_dt = dt.code
      # end
      # unless comp_dt
      #   puts Rainbow("#{dt.code}.#{comp.sequence_number}").red
      #   puts Rainbow(comp.pretty_inspect).yellow
      # end
      f_hash = {}
      # puts comp.class.properties.keys.sort
      # raise
      table = igamt_field_table(f)
      f_hash['table'] = table if table
      f_hash = f_hash.merge({
        'datatype'   => f_dt,
        'minCard'    => f.min_cardinality.to_s, 
        'maxCard'    => f.max_cardinality.to_s,
        'name'       => f.name,
        'position'   => f.sequence_number,
        'usage'      => f.optionality.value,
        'minLength'    => f.min_length.to_s, 
        'maxLength'    => f.max_length.to_s,
        'confLength' => f.c_length.to_s,
        'version'    => '2.9.0'
      })
      fields << f_hash
    end
    this_seg = {
      '_id'         => "HL7#{seg.code}--V2-9",
      'children'    => fields,
      # 'type'        => is_primitive ? 'primitive' : 'complex',
      'name'        => seg.code,
      'description' => seg.name,
      'version'     => '2.9',
      '_class'      => 'gov.nist.hit.hl7.data.domain.Segment'
    }
    # puts dt.code
    # pp this_dt; puts
    json << this_seg
  end

  output_file = File.expand_path('~/projects/v2web/igamt/output/segment_v2_9.json')
  File.write(output_file, JSON.pretty_generate(json))
end
