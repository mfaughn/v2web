def ct_tables_no_sync
  DB.tables.select { |t| t.to_s =~ /^ct_/ }
  # [:ct_identities, :ct_units_of_work, :ct_changes, :ct_problems]
end

def deleted_tables_no_sync
  DB.tables.select { |t| t.to_s =~ /_deleted$/ }
end
