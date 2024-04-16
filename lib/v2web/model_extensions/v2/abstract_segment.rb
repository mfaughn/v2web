module HL7::V2
  class AbstractSegment

    BLANK     = 'tbl_blank.png'      unless defined?(BLANK)
    JOIN_END  = 'tbl_vjoin_end.png'  unless defined?(JOIN_END)
    JOIN_OPEN = 'tbl_vjoin-open.png' unless defined?(JOIN_OPEN)
    JOIN      = 'tbl_vjoin.png'      unless defined?(JOIN)
    LINE      = 'tbl_vline.png'      unless defined?(LINE)
    JOIN_END_OPEN  = 'tbl_vjoin_end-open.png'  unless defined?(JOIN_END_OPEN)

    def container
      structure || segment_sequence || segment_choice
    end
  
    def containing_structure
      c = container
      if c.class.name =~ /::MessageStructure/
        c
      else
        c.containing_structure
      end
    end
  
    def any_segment
      false
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
end
