de_problems = []
des = V2::DataElement.all.select { |de| de.vocab_count > 0 }.each do |e|
  cs = e.code_system
  unless cs
    puts e.inspect; puts
    next
  end
  bt = cs.binding_type
  unless bt
    de_problems << [e,cs]
    next
  end
  # ChangeTracker.start
  # e.binding_type = bt
  # e.save
  # ChangeTracker.commit
end
de_problems.sort_by { |e,cs| cs.table_id.to_i }.each { |e, cs| puts "#{cs.name} - #{cs.table_id} - #{e.fields.map(&:info).join('; ')}" }
puts
comps = V2::Component.all.select { |c| c.vocab_count > 0 }.each do |e|
  cs = e.code_system
  unless cs
    puts e.inspect; puts
    next
  end
  bt = cs.binding_type
  unless bt
    puts "#{e.class.name.demodulize} - #{cs.table_id} - #{e.owner.code}.#{e.sequence_number || '1'}"
    next
  end
  # ChangeTracker.start
  # e.binding_type = bt
  # e.save
  # ChangeTracker.commit
end
puts de_problems.map { |e,cs| cs }.uniq.count