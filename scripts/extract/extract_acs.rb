require_relative 'extractor_helpers'
module V2Web
  class DocXtractor    
    
    def extract_ac_rows(table, title)
      rows = table.css('tr').map do |row|
        cells = row.css('tc').map { |cell| Nokogiri::HTML(extract_raw_tc(cell)).text.strip }
      end
      rows.shift # Get rid of 'Acknowledgment Choreography'
      original_title = rows.shift.first.strip # prefer title, which has already been corrected
      # puts "<<<<<<<<<< START #{title} >>>>>>>>>>"
      headers = rows.shift.map(&:downcase)
      unless headers == ['field name', 'field value: original mode', 'field value: enhanced mode']
        if headers.first == 'field nam'
          puts Rainbow("Problem with #{title} headers are #{headers}").yellow
        else
          raise "#{title} headers are #{headers}" 
        end
      end
      rows
    end
    
    # method has side-effects on rows!
    def prep_msh_rows(rows)
      # MSH-15
      msh15 = rows.shift
      msh15.shift # get rid of 'MSH-15'
      raise msh15.inspect unless msh15.first == 'Blank'
      msh15.shift
      
      msh16 = rows.shift
      msh16.shift # get rid of 'MSH-16'
      raise msh16.inspect unless msh16.first == 'Blank'
      msh16.shift
      [msh15, msh16]
    end
    
    def extract_msg_row(msh1x, rows, title, type)
      row = rows.shift
      row.shift # get rid of Y axis label
      orig_msg = row.shift.strip
      puts Rainbow("#{title} has empty cells").cyan if orig_msg&.empty?
      orig_msg = nil if orig_msg == '-' || orig_msg == ''
  
      answer = {}
      msh1x.each_with_index do |val, i|
        unless val == 'NE' || val == 'AL' || val.split(/,\s*/).sort == ['AL', 'ER', 'SU']
          if val == 'N/A'
            puts Rainbow("Value is N/A in #{type} ack for #{title}").yellow
          elsif val == 'AL, SU, ER, NE'
            puts Rainbow("Value is 'AL, SU, ER, NE' in #{type} ack for #{title}").yellow
          else
            raise "#{val} found in #{title}" 
          end
        end
        ack = row[i]
        if answer[val] && answer[val] != ack
          puts Rainbow("    Ack mismatch in enhanced #{type} for #{title}").red
          puts "Enhanced #{type}: #{answer[val].inspect}\n#{type} ack: #{ack.inspect}"
        end
        if orig_msg && (ack != '-') && (orig_msg != ack)
          puts Rainbow("    Ack mismatch b/w original and enhanced #{type} ack for #{title} -- #{orig_msg.inspect} : #{ack.inspect}").yellow
        end
        answer[val] = ack.gsub("\n", ' ').gsub(/\s+/, ' ') unless ack.to_s.strip == '-' || ack.strip == 'N/A' || ack.empty?
        puts Rainbow("    #{title}: MSH1x #{type} value is #{val} but there is no message.").orange if val =~ /AL/ && answer[val].nil?
      end
      # puts "Enhanced #{type}"
      # pp answer
      [orig_msg, answer]
    end
    
    def extract_ac(table, msg_obj, title)      
      rows = extract_ac_rows(table, title)
      
      msh15, msh16 = prep_msh_rows(rows)
      
      # imm_ack = rows.shift
      # imm_ack.shift # get rid of 'Immediate Ack'
      # orig_imm = imm_ack.shift.strip
      # puts Rainbow("#{title} has empty cells").cyan if orig_imm&.empty?
      # orig_imm = nil if orig_imm == '-' || orig_imm == ''
      
      orig_imm, enhanced_imm = extract_msg_row(msh15, rows, title, "Immediate")
      
      # MSH-16
      begin
        # app_ack = rows.shift
        # app_ack.shift # get rid of 'Application Ack'
        # orig_app = app_ack.shift.strip
        # puts Rainbow("#{title} has empty cells").cyan if orig_app&.empty?
        # orig_app = nil if orig_app == '-' || orig_app == ''
        orig_app, enhanced_app = extract_msg_row(msh16, rows, title, "Application")
      rescue
        if title =~ /RTB\^Znn\^RTB_Knn/ # row missing in standard
          orig_app     = nil
          enhanced_app = {}
        else
          puts "Hey, what is up with #{title}?  It is missing application ack row."
          # raise
        end
      end
      # weird = (enhanced_imm.values + enhanced_app.values).reject { |v| v =~ /^ACK/ }
      # if weird.any?
      #   puts "Message: #{title}"
      #   enhanced_imm.each_value {|v| puts "Immediate: #{v}" unless v =~ /^ACK/ }
      #   enhanced_app.each_value {|v| puts "Application ACK: #{v}" unless v =~ /^ACK/ }
      #   puts
      # end
      
      ChangeTracker.start
      ac_obj = HL7::AcknowledgmentChoreography.new


      # root_message = find_message(title)
      # raise unless root_message
      # puts "Setting AC for #{msg_obj.name}"
      ac_obj.for = msg_obj

      ac_obj.ack_immediate = true if orig_imm
      ac_obj.save
      ChangeTracker.commit
      if orig_imm || orig_app
        orig_msgs = find_or_create_messages(orig_imm || orig_app, msg_obj.name)
        ChangeTracker.start
        ac_obj.original_acks = orig_msgs
        ChangeTracker.commit
      end
      ChangeTracker.start
      raise if orig_imm && orig_app # If this happens, it is an error in the standard we are parsing
      ac_obj.ack_immediate = true  if orig_imm
      ac_obj.ack_immediate = false if orig_app
      ac_obj.msh15 = 'Never'  if enhanced_imm.empty? || enhanced_imm.keys == ['NE']
      ac_obj.msh15 = 'Always' if enhanced_imm.keys == ['AL']
      ac_obj.msh16 = 'Never'  if enhanced_app.empty? || enhanced_app.keys == ['NE']
      ac_obj.msh16 = 'Always' if enhanced_app.keys == ['AL']
      ChangeTracker.commit
      if enhanced_imm.values.uniq.count == 1
        acks = find_or_create_messages(enhanced_imm.values.uniq.first, msg_obj.name)
        ChangeTracker.start
        ac_obj.msh15_acks = acks
        ChangeTracker.commit
      end
      if enhanced_app.values.uniq.count == 1
        mm = find_or_create_messages(enhanced_app.values.uniq.first, msg_obj.name)
        begin
          ChangeTracker.start
          ac_obj.msh16_acks = mm
          ChangeTracker.commit
        rescue
          ChangeTracker.cancel
          puts msg_obj.name
          puts mm.inspect
          pp enhanced_app
          raise
        end
      end
      ChangeTracker.start
      eiv = enhanced_imm.values
      eav = enhanced_app.values
      if orig_imm
        if eiv.count == 1 && orig_imm == eiv.first
          ac_obj.imm_ack_name = orig_imm
        else
          # puts Rainbow("#{orig_imm} & #{enhanced_imm.values.first}").cyan
          ac_obj.imm_ack_name = "FIXME: #{orig_imm} & #{eiv.first}"
        end
      elsif eiv.any?
        if eiv.count == 1
          ac_obj.imm_ack_name = eiv.first
        else
          puts Rainbow("#{eiv.join(' & ')}").cyan
          ac_obj.imm_ack_name = "FIXME: #{eiv.join(' & ')}"
        end
      end
      if orig_app
        if eav.count == 1 && orig_app == eav.first
          ac_obj.app_ack_name = orig_app
        else
          puts Rainbow("      #{orig_app} & #{eav.first}").coral
          ac_obj.app_ack_name = "FIXME: #{orig_app} & #{eav.first}"
        end
      elsif eav.any?
        if eav.count == 1
          ac_obj.app_ack_name = eav.first
        else
          puts Rainbow("#{eav.join(' & ')}").blue
          ac_obj.imm_ack_name = "FIXME: #{eav.join(' & ')}"
        end
      end
      ac_obj.save
      ChangeTracker.commit
      if enhanced_imm.values.uniq.count > 1
        puts Rainbow("#{title} has multiple values for enhanced_imm: #{enhanced_imm.values}").red
      end
      if enhanced_app.values.uniq.count > 1
        puts Rainbow("#{title} has multiple values for enhanced_app: #{enhanced_app.values}").red
      end

# REPORT
      ack_type = case
      when orig_app
        "Application"
      when orig_imm
        "Immediate"
      else
        "None"
      end
      
      # if enhanced_app.keys.include?('AL') || enhanced_imm.keys.include?('AL') || !enhanced_app.keys.include?('NE') || !enhanced_imm.keys.include?('NE')
      # if enhanced_app.keys == ['NE'] || enhanced_imm.keys == ['NE']
      # @@ane ||= []
      # @@ine ||= []
      # if enhanced_app.keys == ['NE']
      #   @@ane << title
      # end
      # if enhanced_imm.keys == ['NE']
      #   @@ine << title
      # end

      if false && enhanced_app.keys == ['NE'] || enhanced_imm.keys == ['NE']
        puts "_____________________________"
        puts title
        if orig_app || orig_imm
          puts "  Original Mode"
          puts "    Ack Type: #{ack_type}"
          puts "    Message:  #{orig_app || orig_imm || '-'}"
        end
        puts "  Enhanced Mode"
        puts "  Field Name  |  Field Value  |  Message"
        enhanced_imm.each do |fv, mg|
          space = 13 - fv.size
          space = 0 if space < 0
          puts "  MSH-15      |  #{fv}#{' '*space}|  #{mg}"
        end
        enhanced_app.each do |fv, mg|
          space = 13 - fv.size
          space = 0 if space < 0
          puts "  MSH-16      |  #{fv}#{' '*space}|  #{mg}"
        end
      end
      # puts "Created AC for #{ac_obj.for.name}."
    end
    
    # def extract_acs(doc, html)
    #   @html = File.open(html) { |f| Nokogiri::XML(f) }
    #   @acs = {}
    #   find_acs
    #   # puts "Found #{@acs.count} ACs"
    #   doc.remove_namespaces!
    #   # TODO - get documentation and everything else....
    #   @acs.each { |name, data| create_ac(name, data) }
    # end
        
    # def find_acs # events are tied in closely here.  we may want to get it all in one go.
    #   @html.at('body').children.each do |node|
    #     next unless node.name == 'table'
    #     title_cell_text = node.css('thead tr th').first&.text&.strip
    #     next unless title_cell_text =~ /^Acknowledge?ment Choreography$/
    #     ac_name = node.css('tbody tr td').first&.text&.strip
    #     ac_names = nil
    #     if ac_name =~ /\w{3}\^\w+\^\w{3}(_\w{3})?/
    #       ac_names = [ac_name]
    #     elsif ac_name =~ /\w{3}\^\w.\d-\w.\d\,(\w{3},)+\w{3}\^\w{3}(_\w{3})?/
    #       # puts Rainbow(ac_name).yellow
    #       ac_name_parts = ac_name.split('^')
    #       letters = ac_name_parts[1].split(',').last.slice(/[A-Z]+/)
    #       nums = ac_name_parts[1].split(',').collect do |e|
    #         if e =~ /-/
    #           inner_nums = e.split('-').collect { |e| e.slice(/\d+/).to_i }
    #           (inner_nums.first..inner_nums.last).to_a
    #         else
    #           e.slice(/\d+/).to_i
    #         end
    #       end
    #       nums.flatten!
    #       ac_names = nums.collect { |n| [ac_name_parts.first, letters + n.to_s.rjust(3 - letters.size, '0'), ac_name_parts.last].join('^') }
    #     elsif ac_name =~ /\w{3}\^\w.\d-\w.\d\^\w{3}(_\w{3})?/
    #       # puts Rainbow(ac_name).yellow
    #       ac_name_parts = ac_name.split('^')
    #       nums = ac_name_parts[1].split('-').collect { |e| e.slice(/\d+/).to_i }
    #       letters = ac_name_parts[1].split('-').first.slice(/[A-Z]+/)
    #       ac_names = (nums.first..nums.last).collect { |n| [ac_name_parts.first, letters + n.to_s.rjust(3 - letters.size, "0"), ac_name_parts.last].join('^') }
    #     elsif ac_name =~ /\w{3}\^\w{3}-\w{3}\^\w{3}(_\w{3})?/
    #       # puts Rainbow(ac_name).yellow
    #       ac_name_parts = ac_name.split('^')
    #       last_letters = ac_name_parts[1].split('-').collect { |e| e[-1] }
    #       first_letters = ac_name_parts[1].split('-').first[0..1]
    #       ac_names = (last_letters.first..last_letters.last).collect { |l| [ac_name_parts.first, first_letters + l, ac_name_parts.last].join('^') }
    #     elsif ac_name =~ /\w{3}\^(\w{3},)+\w{3}\^\w{3}(_\w{3})?/
    #       # puts Rainbow(ac_name).yellow
    #       ac_name_parts = ac_name.split('^')
    #       ac_names = ac_name_parts[1].split(',').collect { |e| [ac_name_parts.first, e, ac_name_parts.last].join('^') }
    #     else
    #       puts 'Skipping ' + Rainbow(ac_name).red + ' because it has a weird format.'
    #     end
    #     ac_names.each { |n| @acs[n] = {:table => node, :base => ac_name} } if ac_names
    #   end
    # end

    def find_or_create_messages(names, root_msg_name = nil)
      msgs = []
      names.split(/\s*or\s*/).each do |name|
        sname = singularize_message_name(name, root_msg_name)
        msg = find_message(sname)
        unless msg
          msg = create_message_definition(fix_name(sname))
          puts "    Created MessageDefinition for #{msg.name}" unless name =~ /^ACK.*ACK$/
        end
        msgs << msg
      end
      msgs.any? ? msgs : nil
    end
    
    def singularize_message_name(ack_msg_name, root_msg_name)
      ack_msg_name = fix_name(ack_msg_name)
      ack_msg_middle = ack_msg_name.split('^')[1]
      return ack_msg_name unless ack_msg_middle =~ /-|,/
      # unless ack_msg_middle == root_msg_name.split('^')[1]
      #   puts Rainbow("#{ack_msg_name} != #{root_msg_name}")
      # end
      fixed_ack_msg_name = ack_msg_name.split('^')
      fixed_ack_msg_name[1] = root_msg_name.split('^')[1]
      fixed_ack_msg_name = fixed_ack_msg_name.join('^')
      # puts 'Fixed name is ' + Rainbow(fixed_ack_msg_name).orange
      fixed_ack_msg_name
    end
    
    def find_message(name)
      name = fix_name(name)
      msg_def = HL7::Message.where(Sequel.like(:name, "#{name}%")).first
      puts Rainbow("    No existing MessageDefinition for #{name}").yellow if !msg_def && name !~ /^ACK.*ACK$/
      msg_def
    end
    
    def fix_name(name)
      name = 'RSP^K24^RSP_K23' if name == 'RSP^K24^RSP_K24' || name == 'RSP^K2^4^RSP_K24'
      name = 'ACK^O16^ACK' if name == 'ACK^ORG^ACK'
      name = 'ACK^O31^ACK' if name == 'ACK^B31^ACK'
      name = 'ACK^O32^ACK' if name == 'ACK^B32^ACK'
      name = 'RRE^O26^RRE_O12' if name == 'RRE^O26^RRE_O26'
      name = 'RRI^I12-I15^RRI_I12' if name == 'RPI^I12-I15^RPI_I12'
      name = 'RSP^K24^RSP_K24' if name == 'RSP^K2^4^RSP_K24'
      name = 'ACK^S01-S11^ACK' if name =~ /^ACK\^S10- ?S11\^ACK$/
      name = 'SRR^S01-S11^SRR_S01' if name == 'ACK^S10-S11^SRR_S01'
      name
    end
        
  end # DocXtractor
end # V2Web
