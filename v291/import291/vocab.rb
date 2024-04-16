module V291
  module_function

  def value_set_definition(numbers_str, message = nil)
    return nil unless numbers_str
    numbers = numbers_str.split(/\s+|,|\//).map(&:strip).select { |s| s.size > 0 }
    puts numbers.inspect if numbers.size > 1
    code_systems = numbers.map { |n| puts n if numbers.size > 1; find_or_create_code_system(n) }
    ctstart
    vsd = HL7::Vocab::ValueSetDefinition.new
    vsd.save
    ctcommit
    ctstart
    code_systems.each { |cs| vsd.add_code_system(cs) }
    ctcommit
    vsd
  end

  def find_or_create_code_system(number)
    cs = HL7::Vocab::CodeSystem.where(table_id:number.to_i).first
    return cs if cs
    ctstart
    cs = HL7::Vocab::CodeSystem.new
    cs.table_id = number.to_i
    cs.save
    ctcommit
    cs
  end
  
end
