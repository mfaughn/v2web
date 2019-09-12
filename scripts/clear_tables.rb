def clear_tables
  (FHIR.classes(:no_imports => true) + V2Web.classes(:ignore_imports => true)).each do |c|
    next unless c < Sequel::Model
    next if c.enumeration?
    if DB.tables.include?(c.table_name)
      c.delete
    end
  end
  nil
end
