# example_file = File.expand_path('~/projects/v2web/igamt/hl7-data/datatype.json')
# show_example(example_file)

def igamt_dt
  datatypes_json = []
  V2::DataType.each do |dt|
    is_primitive = dt.components.count < 2
    comps = []
    dt.components.each do |comp|
      unless (comp.sequence_number == (comp.owner_position + 1)) || (comp.sequence_number.nil? && (comp.owner_position == 0))
      
        raise "#{dt.code}.#{comp.sequence_number} has a problem because it's order number is #{comp.owner_position}"
      end
      # unless comp.type || is_primitive
      #   puts Rainbow("#{dt.code}.#{comp.sequence_number}").yellow + ' ' + comp.optionality.value + ' ' + dt.components.size.to_s
      # end
      usage = comp.optionality.value
      comp_dt = usage == 'W' ? '-' : comp&.type&.code
      if comp_dt.nil? && is_primitive
        comp_dt = dt.code
      end
      unless comp_dt
        puts Rainbow("#{dt.code}.#{comp.sequence_number}").red 
        puts Rainbow(comp.pretty_inspect).yellow
      end
      comp_hash = {}
      # puts comp.class.properties.keys.sort
      # raise
      comp_hash['table'] = 'HL7' + comp.legacy_tbl if comp.legacy_tbl.to_s[0]
      comp_hash = comp_hash.merge({
        'datatype'   => comp_dt,
        'name'       => comp.name,
        'position'   => comp.sequence_number,
        'usage'      => comp.optionality.value,
        'minLength'  => comp.min_length.to_s, 
        'maxLength'  => comp.max_length.to_s,
        'confLength' => comp.c_length.to_s,
        'version'    => '2.9.0'
      })
      comps << comp_hash
    end
    this_dt = {
      '_id'         => "HL7#{dt.code}--V2-9",
      'children'    => comps,
      'type'        => is_primitive ? 'primitive' : 'complex',
      'name'        => dt.code,
      'description' => dt.name,
      'version'     => '2.9',
      '_class'      => 'gov.nist.hit.hl7.data.domain.Datatype'
    }
    # puts dt.code
    # pp this_dt; puts
    datatypes_json << this_dt
  end

  dt_output_file = File.expand_path('~/projects/v2web/igamt/output/datatype_v2_9.json')
  File.write(dt_output_file, JSON.pretty_generate(datatypes_json))
end
# V2::DataType.each do |dt|
  # check to see about primitives with constraints
  # next if dt.withdrawn
  # next if dt.components_count > 1
  # puts dt.code
  # c = dt.components.first
  # puts c.min_length.to_s
  # puts c.max_length.to_s
  # puts c.c_length.to_s
  # puts
# end