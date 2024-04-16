require 'diffy'
module V2PubHelp
  def self.find_refs
    rt_props = {}
    link_props = {}
    links = {}
    chapter_props = {}
    chapters = {}
    Sequel::Model.children.each do |k|
      k.properties.each do |name, data|
        if data[:class] == "Gui_Builder_Profile::RichText"
          rt_props[k] ||= []
          rt_props[k] << name
        end
      end
    end
    # pp rt_props
    # rt_props.each do |k,props|
    #   next if k.to_s =~ /FHIR::|MarkupType/
    #   # puts Rainbow(k.to_s).orange
    #   # props.each do |prop|
    #   #   puts Rainbow(k.properties[prop].pretty_inspect).cyan
    #   # end
    #   instances = k.all
    #   props.each do |prop|
    #     has_link = instances.find do |i|
    #       text = i.send((prop.to_s + '_content').to_sym)
    #       text.to_s =~  /href/
    #     end
    #     if has_link
    #       link_props[k] ||= []
    #       link_props[k] << prop
    #     end
    #   end
    #   props.each do |prop|
    #     has_chap = instances.find do |i|
    #       text = i.send((prop.to_s + '_content').to_sym)
    #       text.to_s =~  /Ch\.|Chapter|chapter/
    #     end
    #     if has_chap
    #       chapter_props[k] ||= []
    #       chapter_props[k] << prop
    #     end
    #   end
    # end
    rt_props.each do |k,props|
      next if k.to_s =~ /FHIR::|MarkupType/
      # puts Rainbow(k.to_s).orange
      # props.each do |prop|
      #   puts Rainbow(k.properties[prop].pretty_inspect).cyan
      # end
      instances = k.all
      next if instances.size == 0
      # puts Rainbow("#{k} -- #{instances.size}").cyan
      instances.each do |i|
        props.each do |prop|
          text = i.send((prop.to_s + '_content').to_sym)
          has_link = text.to_s =~  /href/
          if has_link
            links[k] ||= {}
            links[k][prop] ||= []
            links[k][prop] << i
          end
          has_chap = text.to_s =~  /Ch\.|Chapter|chapter/
          if has_chap
            chapters[k] ||= {}
            chapters[k][prop] ||= []
            chapters[k][prop] << i
          end
          # if has_chap || has_link
          #   puts Rainbow(prop.to_s).yellow + ' ' + text[0..31].inspect + (has_link ? ' LINK' : '') + (has_chap ? ' CHAP' : '')
          # end
        end
      end
    end

    puts '______________________________________________________________'
    links.each do |k,props|
      puts Rainbow(k.to_s).orange
      props.each do |prop, instances|
        puts "#{prop} --> #{instances.size}"
      end
    end
    puts '______________________________________________________________'
    chapters.each do |k,props|
      puts Rainbow(k.to_s).orange
      props.each do |prop, instances|
        puts "#{prop} --> #{instances.size}"
      end
    end
  end
  
  def self.wassup
    # pp HL7::V2::DefinitionText.properties.select { |_,d| d[:association] }
    # orphans = V2::DefinitionText.where(data_element_id:nil).limit(100).all
    # pp orphans
    # orphans.each { |o| puts o.content_content; puts}
    # return
    puts "There are #{HL7::V2::DataElement.count} DataElements"
    puts "There are #{HL7::V2::Field.count} Fields"
    des = {}
    fields = {}
    de_orphans = []
    field_only = []
    dts = HL7::V2::DefinitionText.all
    puts "There are #{dts.size} DefinitionTexts"
    dts.each do |deftext|
      de = deftext.data_element
      if de
        des[de] ||= []
        des[de] << deftext
      else
        de_orphans << deftext
      end
      # if dt.fields_count > 0
      #   dt.fields.each do |f|
      #     key = f.code
      #     des[key] ||= []
      #     des[key] << dt
      #   end
      #   field_only << dt unless de
      # end
    end
    puts "de_orphans --> #{de_orphans.size}"
    # puts "field_only --> #{field_only.size}"
    puts "de texts --> #{des.keys.size}"
    # puts "field texts --> #{fields.keys.size}"
    @@orphans = de_orphans
  end
  
  def self.wassup2
    wassup
    html = []
    no_field = []
    no_def = []
    @@different = {}
    sameAsField = []
    @@field_defs  = {}
    V2PubHelp.orphans.each do |o|
      oc = o.original_container
      field = Utils.get_field(oc)
      unless field
        puts "No Field #{oc}"
        no_field << o
        next
      end
      fd = field.definition
      unless fd
        no_def << field
        puts "No Definition for #{field.code}"
        next
      end
      same = fd.definition_content == o.definition_content
      if same && o.data_element.nil? && o.fields.empty?
        ChangeTracker.start
        o.destroy
        ChangeTracker.commit
      end
      field_defs[field.code] = fd.definition_content
      different[field.code] ||= []
      different[field.code] << o
    end
    # puts "No Field #{no_field.size}"
    # puts "No Def #{no_def.size}"
    puts "Same As Field: #{sameAsField.size}"
    puts "Different from Field: #{different.values.map(&:size).reduce(&:+)}"
    # [no_field, no_def, different]
    @@different.each do |field_code, dts|
      fd = @@field_defs[field_code]
      field = Utils.get_field(fd.original_container)
      dts = dts.uniq
      html << "<div><h4>#{field.info}</h4>"
      html << Diffy::SplitDiff.new(fd, fd, :format => :html).right
      dts.each do |dt|
        html << Diffy::SplitDiff.new(fd, dt.definition_content, :format => :html).right
      end
      html << "</div>"
      html << '<hr>'
      # next # NEXT
      # puts Rainbow(field_code).orange
      # dts.each do |dt|
      #   oc = dt.original_container
      #   field = Utils.get_field(oc)
      #
      #   puts dt.definition_content
      #   puts '_____________'
      # end
      # field = Utils.get_field(field_code)
      # puts field.definition.definition_content
      # puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%';puts
    end
    path = (File.join(__dir__, "field_defs.html"))
    File.open(path, 'w+') { |f| f.puts html.join("\n") }
  end
  
  def self.orphans
    @@orphans
  end
end
# V2PubHelp.find_refs
V2PubHelp.wassup2
