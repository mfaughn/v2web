load '/Users/mfaughn/projects/v2web/publisher/model_extensions/code_system.rb'
ALL_CDS = Vocab::ConceptDomain.all unless defined?(ALL_CDS)
def vocab_info
  ALL_CDS.each do |cd|
    css = cd.code_systems
    if css.size > 1
      # puts Rainbow(cd.name).green
      # css.each {|cs| puts "#{cs.table_id} - #{cs.name}"}
      # puts
    elsif css.size < 1 # There are none!
      # puts cd.name 
    else
      cs = css.first
      n = cs.concepts_count
      if n < 1
        pp cd
        cs.stat
        return
      end
    end
  end
end
vocab_info