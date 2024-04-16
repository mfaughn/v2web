# example_file = File.expand_path('~/projects/v2web/igamt/hl7-data/messageStructure.json')
# show_example(example_file)
def igamt_msg
  json = []
  structs = V2::MessageStructure.sort_by { |struct| struct.code }
  structs.each do |struct|
    events = []
    struct.messages.sort_by { |msg| msg.code }.each do |msg|
      events << {
        'name' => msg.code,
        'description' => msg.name,
        'version' => '2.9'
      }
    end
    segments = []
    struct.segments.each do |seg|
      segments << create_igamt_seg_hash(seg, struct)
    end

    this_msg = {
      '_id'         => "HL7#{struct.code}--V2-9",
      'messageType' => struct.code.slice(/^.+(?=_)/),
      'structID'    => struct.code,
      'events'      => events,
      'children'    => segments,
      # 'type'        => is_primitive ? 'primitive' : 'complex',
      'name'        => struct.name,
      'description' => nil,
      'version'     => '2.9',
      '_class'      => 'gov.nist.hit.hl7.data.domain.MessageStructure'
    }
    json << this_msg
  end

  output_file = File.expand_path('~/projects/v2web/igamt/output/messageStructure_v2_9.json')
  File.write(output_file, JSON.pretty_generate(json))
end

def create_igamt_seg_hash(seg, msg, top = true)
  seg_hash = {}
  if seg.class == HL7::V2::Segment
    seg_hash['segment'] = seg.type.code
    seg_hash['_class']  = 'gov.nist.hit.hl7.data.domain.SegmentRef'
  elsif seg.class == HL7::V2::SegmentSequence
    seg_hash['children']  = seg.segments.map { |s| create_igamt_seg_hash(s, msg, false) }
    seg_hash['groupType'] = 'SEQUENCE'
    seg_hash['_class']    = 'gov.nist.hit.hl7.data.domain.Group'
  elsif seg.class == HL7::V2::SegmentChoice
    seg_hash['children']  = seg.segments.map { |s| create_igamt_seg_hash(s, msg, false) }
    seg_hash['groupType'] = 'CHOICE'
    seg_hash['_class']    = 'gov.nist.hit.hl7.data.domain.Group'
  elsif seg.class == HL7::V2::ExampleSegment
    seg_hash['segment'] = seg.name
    seg_hash['_class']  = 'gov.nist.hit.hl7.data.domain.SegmentRef'
  else
    pp msg.messages
    puts '--------'
    pp seg
    raise seg.class.name
  end
  position = seg.structure_position ? seg.structure_position + 1 : 0
  seg_hash = seg_hash.merge({
                 'usage'      => seg.optional ? 'O' : 'R',
                 'position'   => position,
                 'minCard'    => seg.optional ? '0' : '1',
                 'maxCard'    => seg.repeat ? '*' : '1',
                 'name'       => seg.is_a?(V2::Segment) ? seg.type.name : seg.name
                 })
  seg_hash
end

# def create_igamt_seg_hash_sequence(seg, msg, position = nil)
#   segments = []
#   seg.segments.each do |seg|
#     segments << create_igamt_seg_hash(seg, msg)
#   end
#   seg_hash = {}
#   if seg.class == HL7::V2::Segment
#     seg_hash['segment'] = seg.code
#   elsif seg.class == HL7::V2::SegmentSequence
#     seg_hash['children'] = create_igamt_seg_hash_sequence(seg)
#   elsif seg.class == HL7::V2::SegmentChoice
#     pp msg
#     raise 'SegmentChoice'
#   end
#   seg_hash.merge({
#                    'usage'      => seg.optionality.value,
#                    'position'   => 0.#f.sequence_number,
#                    'minCard'    => seg.min_cardinality.to_s,
#                    'maxCard'    => seg.max_cardinality.to_s,
#                    'name'       => seg.name,
#                    '_class'     => 'gov.nist.hit.hl7.data.domain.SegmentRef'
#                  })
#   seg_hash
# end
