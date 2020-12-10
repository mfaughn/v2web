module HL7Parse
  def self.decrypt_link(run, link, opts = {})
    LinkDecrypter.new(run, link, opts).decrypt
  end
  
  # class methods 
  class LinkDecrypter
    def self.seg_field_index
      @seg_field_index ||= JSON.parse(File.read(File.expand_path('~/projects/v2web/test_data/seg_field_index.json')))
    end

    def self.seg_index
      @seg_index ||= seg_field_index.map { |sf| sf.split('-').first }.uniq
    end
    
    def self.dt_comp_index
      @dt_comp_index ||= JSON.parse(File.read(File.expand_path('~/projects/v2web/test_data/dt_comp_index.json')))
    end

    def self.dt_index
      @dt_index ||= dt_comp_index.map { |dt| dt.split('-').first }.uniq
    end

    def self.title_index(link, chapter = nil)
      if chapter
        _title_index[chapter][link]
      else
        matches = []
        _title_index.each { |ch, index| matches << index[link] }
        matches.compact!
        return nil if matches.empty?
        matches.sort_by{ |m| m.scan('.').count }
        level = matches.first.scan('.').count
        matches.select! { |m| m.scan('.').count == level }
        puts Rainbow("Multiple matches for #{link} -- #{matches.inspect}").lime if matches.count > 1
        matches.first
      end
    end
    
    def self.fuzzy_title_index(link, chapter = nil)
      matches = []
      matches << (chapter ? _fuzz_ch(link, chapter) : _fuzz_ch(link))
      matches.flatten!
      matches.compact!
      return nil if matches.empty?
      # return link to whichever section is hierarchically highest
      matches.sort_by{ |m| m.scan('.').count }
      level = matches.first.scan('.').count
      matches.select! { |m| m.scan('.').count == level }
      puts Rainbow("Multiple fuzzy matches for #{link.inspect} -- #{matches.inspect}").lime if matches.count > 1
      matches.first
    end
    
    def self._fuzz_ch(link, chapter = nil)
      regex   = /#{Regexp.escape(link)}/i
      matches = []
      if chapter
        _title_index[chapter].each { |section_title, num| matches << num if (section_title =~ regex) }
      else
        _title_index.each_key { |k| matches << _fuzz_ch(link, k) }
      end
      matches.flatten.compact
    end
    
    def self._title_index
      return @title_index if @title_index
      @title_index = {}
      chapter_num_to_link_title_index.each_key do |ch| 
        @title_index[ch] ||=  JSON.parse(File.read(File.expand_path("~/projects/v2web/test_data/chapter_indices/Chapter#{ch}.json")))
      end
      @title_index
    end

    def self.chapter_num_to_link_title(num)
      chapter_num_to_link_title_index[num]
    end
    
    def self.chapter_num_to_link_title_index
      {
        '1'  => 'Introduction',
        '2'  => 'Control',
        '2A' => 'Data-Type',
        '3'  => 'Patient-Administration',
        '4'  => 'Order-Entry-General-Laboratory-Dietary-Supply-Blood-Transfusion',
        '4A' => 'Order-Entry-Pharmacy-Treatment-Vaccination',
        '5'  => 'Query',
        '6'  => 'Financial-Management',
        '7'  => 'Observation-Reporting',
        '8'  => 'Master-Files',
        '9'  => 'Medical-Records-Information-Management-Document-Management',
        '10' => 'Scheduling',
        '11' => 'Patient-Referral',
        '12' => 'Patient-Care',
        '13' => 'Clinical-Laboratory-Automation',
        '14' => 'Application-Management',
        '15' => 'Personnel-Management',
        '16' => 'Claims-and-Reimbursement',
        '17' => 'Materials-Management'
      }
    end
    
    def self.email?(str)
      str =~ email_regex
    end
    
    def self.email_regex
      /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i
    end
    
    def self.decrypt_absolute_links(link)
      return link if link =~ /https?:\/\/.+/
      return link if link =~ /mailto:.+@.+/
      if link =~ /^hl7\.org/
        ret = 'http://' + link
        # puts Rainbow("HL7: #{ret}").chartreuse
        return ret
      end
      if link =~ /^www\./
        ret = 'http://' + link
        # puts Rainbow("WWW: #{ret}").chartreuse
        return ret
      end
      if email?(link)
        ret = 'mailto:' + link
        # puts Rainbow("Email: #{ret}").chartreuse
        return link
      end
    end
  end
  
  # instance methods
  class LinkDecrypter  
    def initialize(run, link, opts)
      @run = run
      @link = link.strip.gsub('&#38;', '&').gsub(/[–|-]/, '-')
      # link = run.link.strip
      @chapter = opts[:chapter]
      @external = opts[:external_link]
      @text     = opts[:text].to_s.strip
    end
    
    def decrypt(link = nil)
      link ||= @link
      link = fix_v2_link(link)
      # puts Rainbow(link).chartreuse
      success = LinkDecrypter.decrypt_absolute_links(link)
      return success if success

      # reference to tables / value set -- redirect to FHIR of Frank's site
      return "https://www.hl7.org/fhir/v2/#{$1}/index.html" if link =~ /[HL7|User.defined] [T|t]able (\d\d\d\d)/ || link =~ /^(0\d\d\d)$/
      # return "http://www.hl7.eu/refactored/tab#{$1}.html" if link =~ /HL7 [T|t]able (\d\d\d\d)/

      ### This can't be added to one-offs because it can results in a loop
      # Link is to a docx file but text indicates where in docx file
      if link =~ /\.docx/
        success = decrypt(@run.text)
        return success if success
      end
      
      success = decrypt_one_offs || decrypt_type_id || decrypt_section_number
      return success if success
      

      # Try to figure out where we're going based on finding which section matches the text and returning the numerical lookup.  Assumes that text is a section title.
      # First try to find it in this chapter, otherwise look everywhere
      sect_num = LinkDecrypter.title_index(link, @chapter) || LinkDecrypter.title_index(link)
      sn_link  = decrypt_section_number(sect_num) if sect_num
      return sn_link if sn_link

      # now we're going chop things up and look for type ids
      link.split(/,|\./).map(&:strip).each do |title_part|
        success = decrypt_type_id(title_part)
        return success if success
      end

      success = fuzzy_decrypt(link)
      return success if success

      if @external
        puts "External link: #{link.inspect}"
      else
        puts "Internal link: #{link.inspect}"
        # puts @run.node;puts
      end
      
      # decrypted_text = decrypt(@text)
      link
    end
    
    def fix_v2_link(link)
      case link
      when 'Pid'
        'PID'
      when 'Pid-3 - Patient Identifier List'
        'PID-3 - Patient Identifier List'
      when 'QRF-9-When quantity/timing qualifier'
        'QRF-9-When quantity/timing qualifier' 
      else
        link
      end
    end
    
    # special situations
    def decrypt_one_offs(link = nil)
      link ||= @link
      return 'http://www.hl7.org/legal/ippolicy.cfm?ref=nav' if link == 'IP Compliance Policy'
      return "data-types.html" if link == 'file:///D:\\Eigene%20Dateien\\V27_CH02A_DataTypes.doc'
      return 'mailto:wkubick@HL7.org' if link == 'file:///E:/V29_Preparation/2018SEP/updated chapters/V29_2018SEP_submitted/wkubick@HL7.org'
      return '/data-type/PPN.html#PPN-1' if link == 'TXA–22.1 Authentication person'
      
      # reference to tables / value set -- redirect to FHIR of Frank's site
      if link == 'V29_CH02C_Tables.docx'
        @text =~ /HL7 [T|t]able (\d\d\d\d)/
        return "https://www.hl7.org/fhir/v2/#{$1}/index.html"
        # return "http://www.hl7.eu/refactored/tab#{$1}.html"
      end
    end
    
    def decrypt_type_id(link = nil)
      link ||= @link
      return link if link.strip.empty?
      
      # Segment field sections
      if link =~ /[–|-]?([A-Z][A-Z0-9]{2}[–|-]\d+)/
        # puts "Matches Seg Field: #{link}"
        seg_match = $1.gsub(/[–|-]/, '-')
        if LinkDecrypter.seg_field_index.include?(seg_match)
          seg = seg_match.split(/[–|-]/).first
          return "/segment-definition/#{seg}.html##{seg_match}"
        end
      end

      # Segments
      if link =~ /^([A-Z][A-Z0-9]{2})$/ || link =~ /^([A-Z][A-Z0-9]{2} [–|-] .+)/
        # puts "Matches Seg Field: #{link}"
        seg = $1[0..2]
        if LinkDecrypter.seg_index.include?(seg)
          return "/segment-definition/#{seg}.html"
        end
      end
      
      # Data Type component sections
      if link =~ /[–|-]?([A-Z][A-Z0-9]{1,2}[–|-|–|\.]\d+)/
        dt_match = $1.gsub(/[–|-|–|\.]/, '-')
        # puts "Matches Data Type component: #{link}"
        if LinkDecrypter.dt_comp_index.include?(dt_match)
          dt = dt_match.split(/[–|-|–|\.]/).first
          return "/data-type/#{dt}.html##{dt_match}"
        end
      end

      # Data Types
      if link =~ /^([A-Z][A-Z0-9]{1,2})$/ || link =~ /^([A-Z][A-Z0-9]{1,2} [–|-] .+)/
        # puts "Matches Data Type: #{link}"
        dt = $1[0..2]
        if LinkDecrypter.dt_index.include?(seg)
          return "/data-type/#{dt}.html"
        end
      end
    end
    
    def decrypt_section_number(link = nil)
      link ||= @link
      return link if link.strip.empty?
      adjusted_link = link.gsub('2.A', '2A').gsub('4.A', '4A')
      # dotted references to chapters -- FIXME may need to adjust second level due to removal of TOC
      if adjusted_link =~ /((\d+\.)+\d+)/
        ch = LinkDecrypter.chapter_num_to_link_title($1.split('.').first)
        sections = $1.split('.')[1..-1].join('-')
        return "/composition/#{ch}.html##{ch}-#{sections}" if ch
      end
    
      if adjusted_link =~ /^(\d)A?\.?$/
        ch = LinkDecrypter.chapter_num_to_link_title($1.delete('.'))
        return "/composition/#{ch}.html" if ch
      end
    end
    
    def fuzzy_decrypt(link = nil)
      link ||= @link
      return link if link.empty? || link =~ /^[,\.:;"]+$/ || link == '&quot;'
      puts Rainbow("Fuzzy Decrypt: #{@link.inspect}").chartreuse
      # now we're going to fuzzy search for titles that match what is probably an event identifier
      if link =~ /([A-Z][A-Z0-9]{2})/
        # puts Rainbow($1).crimson
        sect_num = LinkDecrypter.fuzzy_title_index($1, @chapter) || LinkDecrypter.fuzzy_title_index($1)
        fz_link  = decrypt_section_number(sect_num) if sect_num
        return fz_link if fz_link
      end
      
      # now we're going to fuzzy search on damn near everything...
      link.split(/,|\.|–|-|–/).map(&:strip).each do |title_part|
        if title_part =~ /((\d+\.)+\d+)/ || title_part =~ /^\d$/
          fzlink = decrypt_section_number(title_part)
          return fz_link if fz_link
        else
          sect_num = LinkDecrypter.fuzzy_title_index(title_part, @chapter) || LinkDecrypter.fuzzy_title_index(title_part)
          fz_link  = decrypt_section_number(sect_num) if sect_num
          return fz_link if fz_link
        end
      end
      link
    end

  end # class LinkDecrypter
end