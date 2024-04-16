module HL7
  module V2
    module Utils
      module_function
      def get_field(str, silent = true)
        seg_code, seq_num = str.split('.')
        seg_def = get_segdef(seg_code)
        field = seg_def.get_field(seq_num)
        unless field
          puts Rainbow("No field for #{str}").magenta unless silent
          return nil
        end
        field
      end
      def get_segdef(code)
        seg_defs = V2::SegmentDefinition.where(code:code.strip).all
        if seg_defs.empty?
          puts Rainbow("No SegmentDefinition for #{seg_code}").cyan unless silent
          return nil
        end
        if seg_defs.size > 2
          raise "Multiple SegmentDefinitions for #{seg_code}"
        end
        seg_defs.first
      end
    end
  end
end
Utils = HL7::V2::Utils unless defined?(Utils)
