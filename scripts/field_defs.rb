module V2Help
  def self.des
    @@des ||= V2::DataElement.all;
  end
  def self.desmulti
    @@desmulti ||= des.select { |d| d.definitions_count > 1 };
  end
  def self.link_field_defs
    desmulti.each do |de|
      de.definitions.each do |dfn|
        str = dfn.original_container
        field = Utils.get_field(str)
        unless field
          puts Rainbow("No field for #{str}").orange
          next
        end
        ChangeTracker.start
        field.definition_text = dfn
        field.save
        ChangeTracker.commit
      end
    end
  end
  # moved to Utils
  # def self.get_field(str)
  #   seg_code, seq_num = str.split('.')
  #   seg_defs = V2::SegmentDefinition.where(code:seg_code.strip).all
  #   if seg_defs.empty?
  #     puts Rainbow("No SegmentDefinition for #{seg_code}").cyan
  #     return nil
  #   end
  #   if seg_defs.size > 2
  #     raise "Multiple SegmentDefinitions for #{seg_code}"
  #   end
  #   field = seg_defs.first.fields.find { |f| f.sequence_number == seq_num.strip.to_i }
  #   unless field
  #     puts Rainbow("No field for #{str}").magenta
  #     return nil
  #   end
  #   field
  # end
end
V2Help.link_field_defs

# TODO move this
class V2::Field

end