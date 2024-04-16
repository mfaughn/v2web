#  diffing Ruby Sequel schemas
def diff_schemas(source, target, table, mapped_table = nil)
  oldschema = source.schema(table)
  newschema = target.schema(mapped_table || table)
  if oldschema != newschema
    report = [Rainbow(table).darkorange]
    issue_found = false
    found = []
    oldschema.each do |oldname, oldschema|
      nn, ns = newschema.find { |newname, newschema| oldname == newname }
      if ns
        found << nn
        next if oldschema == ns
        num = source[table.to_sym].exclude(oldname => nil).count.to_s
        report << 'Changed: ' + Rainbow(oldname.to_s).orange + Rainbow(" #{num} ").plum + oldschema.to_s
        report << 'To:      ' + nn.to_s + ' ' + Rainbow(ns.to_s).cyan
        issue_found = true
      else
        num = source[table.to_sym].exclude(oldname => nil).count.to_s
        report <<  Rainbow('Gone: ').palegoldenrod + oldname.to_s + Rainbow(" #{num} ").plum + Rainbow(oldschema.to_s).palegoldenrod
        issue_found = true
      end
    end
    newschema.each do |newname, newschema|
      next if found.include?(newname)
      report <<  Rainbow('New: ').chartreuse + newname.to_s + ' ' + Rainbow(newschema.to_s).chartreuse
      issue_found = true
    end
    if issue_found
      puts report.join("\n")
      puts '----------------------------------------'
      return false
    end
    true
  end
end
