module LinkVocab
  module_function
  
  def fhir_folder
    '/Users/mfaughn/projects/v2fhir/v2_plus_'
  end

  def parse_dt
    folder = fhir_folder + 'data_types'
    files  = Dir[folder + '/*']
    files.each do |file|
      doc = File.open(file) { |f| Nokogiri::XML(f) }
      xml = doc.css('DataTypeDefinition')
      abbr = xml.at_css('abbreviation').attr('value')
      objs = HL7::V2::DataType.where(code:abbr).all
      obj = objs.first if objs.size == 1
      raise "#{objs.size} entries in DB for DataType #{abbr} - #{name}" unless obj
      xml_components = xml.css('component')
      if obj.components_count != xml_components.size
        puts Rainbow('Components size different for ' + abbr).red 
        next
      end
      stored_components = obj.components
      xml_components.each_with_index do |xc, i|
        b = xc.at_css('binding')&.attr('value')
        next unless b
        tablenum = b.slice(/(?<=\/)\d+(?=\/)/)
        if tablenum
          cs  = Vocab::CodeSystem.where(table_id:tablenum.to_i).first
          if cs
            comp = stored_components[i]
            if comp.vocab
              tid = comp.vocab.code_systems.first.table_id
              if tid == tablenum.to_i
                puts Rainbow("#{obj.code}.#{i + 1}  ").green + tid.to_s
              else
                puts Rainbow("#{obj.code}.#{i + 1} ").orange + tid.to_s
              end
            else
              ChangeTracker.start
              vsd = Vocab::VSD.new
              vsd.add_code_system(cs)
              vsd.save
              comp.vocab = vsd
              comp.save
              ChangeTracker.commit
              puts Rainbow("#{obj.code}.#{i + 1} ").cyan + comp.vocab.code_systems.first.table_id.to_s
            end
          else
            puts Rainbow("#{obj.code}.#{i + 1} ").yellow + tablenum.to_s
          end
        else
          puts Rainbow("#{obj.code}.#{i + 1} ").red + b
        end
      end
    end
  end
  
  def parse_de
    folder = fhir_folder + 'data_elements'
    files  = Dir[folder + '/*']
    files.each do |file|
      doc = File.open(file) { |f| Nokogiri::XML(f) }
      xml = doc.css('DataElementDefinition')
      table = xml.at_css('table')&.attr('value')
      next unless table
      num = xml.at_css('itemNumber').attr('value')
      objs = HL7::V2::DataElement.where(item_number:num).all
      obj = objs.first if objs.size == 1
      raise "#{objs.size} entries in DB for DataElement #{num} - #{name}" unless obj
      tablenum = table.slice(/(?<=\/)\d+(?=\/)/)
      if tablenum
        cs  = Vocab::CodeSystem.where(table_id:tablenum.to_i).first
        if cs
          if obj.vocab
            tid = obj.vocab.code_systems.first.table_id
            if tid == tablenum.to_i
              puts Rainbow("#{obj.item_number} ").green + tid.to_s
            else
              puts Rainbow("#{obj.item_number} ").orange + tid.to_s
            end
          else
            ChangeTracker.start
            vsd = Vocab::VSD.new
            vsd.add_code_system(cs)
            obj.vocab = vsd
            obj.save
            ChangeTracker.commit
            puts Rainbow("#{obj.item_number} ").cyan + obj.vocab.code_systems.first.table_id.to_s
          end
        else
          puts Rainbow("#{obj.code}.#{i + 1} ").yellow + tablenum.to_s
        end
      else
        puts Rainbow("#{obj.code}.#{i + 1} ").red + b
      end
    end
  end

  def go
    parse_dt
    parse_de
  end
end
LinkVocab.go