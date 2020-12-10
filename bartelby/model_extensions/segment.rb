module V2Plus
  
  def self.make_segment(node)
    if node.xpath('./segment').any?
      V2Plus::Segment.make(node)
    elsif node.xpath('./sequence').any?
      V2Plus::SegmentSequence.make(node)
    elsif node.xpath('./choice').any?
      V2Plus::SegmentChoice.make(node)
    elsif node.xpath('./exampleSegment').first
      V2Plus::ExampleSegment.make(node)
    else
      puts node
      raise "What is this #{node.class}?"
    end
  end
  
  class AbstractSegment
    BLANK     = 'tbl_blank.png'      unless defined?(BLANK)
    JOIN_END  = 'tbl_vjoin_end.png'  unless defined?(JOIN_END)
    JOIN_OPEN = 'tbl_vjoin-open.png' unless defined?(JOIN_OPEN)
    JOIN      = 'tbl_vjoin.png'      unless defined?(JOIN)
    LINE      = 'tbl_vline.png'      unless defined?(LINE)
    JOIN_END_OPEN  = 'tbl_vjoin_end-open.png'  unless defined?(JOIN_END_OPEN)
    attr_accessor :any_hl7_segment
    def self.make(node, identifier = nil)
      this = new
      this.repeat   = node.get_val('mayRepeat') == 'true'
      this.optional = node.get_val('optional')  == 'true'
      this.status   = node.at_xpath('status')&.[]('value')
      this.any_hl7_segment = node.get_val('anyHl7Segment') == 'true'
      this
    end
    
    def common_locals
      locals = {
        :cardinality    => cardinality_string,
        :must_implement => optional ? '' : 'Yes',
        :status         => status
      }
    end
    
    def cardinality_string
      card = (optional ? '0..' : '1..')
      card << (repeat ? '*' : '1')
      card
    end
    
    # this method is only for SegmentSequence and SegmentChoice
    def segment_rows(is_last, icons)
      rows = []
      segments.each_with_index do |seg, i|
        row_icons = icons.dup.push(is_last ? BLANK : LINE)
        rows << seg.to_message_row((i == segments.size - 1), row_icons)
      end
      rows
    end
    
    def row_id
      begin
        container.row_id + '-' + container.segments.index(self).succ.to_s
      rescue
        puts self.inspect
        puts container.inspect
        raise
      end
    end
    
  end
  
  class Segment < AbstractSegment
    def self.make(node, identifier = nil)
      this = super(node)
      # FIXME
      this.description  = node.css('description > div')&.to_html
      seg_url = node.get_val('segment')
      if seg_url
        this.type = V2Plus::SegmentDefinition.get(seg_url)
        raise "No segment definition for #{seg_url}" unless this.type
      else
        puts "No segment definition specified..."
        pp node
      end
      this
    end
    
    def info
      if repeat && optional
        "[{ #{type.code} }]"
      elsif optional
        "[ #{type.code} ]"
      elsif repeat
        "{ #{type.code} }"
      else
        type.code
      end
    end
    
    def to_message_row(is_last, icons = [])
      icon = is_last ? JOIN_END : JOIN
      locals = {
        :row_id  => row_id,
        :icon    => icon,
        :icons   => icons,
        :code    => type.code,
        :seg_url => "/segment-definition/#{type.code}.html"
      }.merge(common_locals)
      puts caller if icons == false
      row = V2Plus.render_with_locals(:message_structure, :segment, locals)
    end
  end
  
  class SegmentSequence < AbstractSegment
    def self.make(node, identifier = nil)
      this = super(node)
      seq = node.at_xpath('./sequence')
      this.name = seq.get_val('name')
      this.segments = seq.xpath('./segmentEntry').map { |se| V2Plus.make_segment(se) }
      this
    end
    def info
      segs_info = segments.map { |seg| seg.info }.join("\n")
      if repeat && optional
        "[{ -- #{name} begin\n#{segs_info}\n}] -- #{name} end"
      elsif optional
        "[ -- #{name} begin\n#{segs_info}\n] -- #{name} end"
      elsif repeat
        "{ -- #{name} begin\n#{segs_info}\n} -- #{name} end"
      else
        raise "What's going on here?"
      end
    end
    def to_message_row(is_last, icons = [])
      icon = is_last ? JOIN_END_OPEN : JOIN_OPEN
      locals = {
        :row_id       => row_id,
        :icon         => icon,
        :icons        => icons,
        :name         => name,
        :segment_rows => segment_rows(is_last, icons).join("\n")
      }.merge(common_locals)
      row = V2Plus.render_with_locals(:message_structure, :segment_sequence, locals)
    end    
  end
  
  class SegmentChoice < AbstractSegment
    def self.make(node, identifier = nil)
      this = super(node)
      choice = node.at_xpath('./choice')
      this.name = choice.get_val('name')
      this.segments = choice.xpath('./segmentEntry').map { |se| V2Plus.make_segment(se) }
      this
    end
    def info
      segs_info = segments.map { |seg| seg.info }.join("\n")
      "< -- #{name} begin\n#{segs_info}\n> -- #{name} end"
    end
    def to_message_row(is_last, icons = [])
      # puts
      # puts Rainbow(info).green
      icon = is_last ? JOIN_END : JOIN
      or_row_locals = {:icon => (is_last ? BLANK : LINE), :icons => icons, :row_id => row_id+'or'}
      locals = {
        :row_id       => row_id,
        :icon         => icon,
        :icons        => icons,
        :name         => name,
        :segment_rows => segment_rows(is_last, icons).join(or_row(or_row_locals))
      }.merge(common_locals)
      row = V2Plus.render_with_locals(:message_structure, :segment_choice, locals)
    end
    
    def or_row(locals)
      "\n" + V2Plus.render_with_locals(:message_structure, :or_row, locals) + "\n"
    end
      
  end
  
  class ExampleSegment < AbstractSegment
    def self.make(node, identifier = nil)
      this = super(node)
      this.name = node.get_val('exampleSegment')
      this.description  = node.css('description > div')&.to_html
      this
    end
    def info
      "#{name} -- EXAMPLE SEGEMENT -- #{description}"
    end
    def to_message_row(is_last, icons = [])
      icon = is_last ? JOIN_END : JOIN
      locals = {
        :row_id      => row_id,
        :icon        => icon,
        :icons       => icons,
        :name        => name,
        :description => description
      }.merge(common_locals)
      row = V2Plus.render_with_locals(:message_structure, :example_segment, locals)
    end
    
  end
  
end
