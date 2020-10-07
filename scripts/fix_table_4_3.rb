vals = [
  "MSH",
  "[{&nbsp;SFT&nbsp;}]",
  "[&nbsp;&nbsp;UAC&nbsp;&nbsp;]",
  "PID",
  "[&nbsp;&nbsp;PD1&nbsp;&nbsp;]",
  "[{&nbsp;NK1&nbsp;}]",
  "&#8230;",
  "[{",
  "&nbsp;&nbsp;&nbsp;ORC",
  "&nbsp;&nbsp;&nbsp;[{&nbsp;PRT&nbsp;}]",
  "&nbsp;&nbsp;&nbsp;[{",
  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TQ1",
  "&nbsp;&nbsp;&nbsp;[{&nbsp;TQ2&nbsp;}]",
  "&nbsp;&nbsp;&nbsp;}]",
  "&nbsp;&nbsp;&nbsp;RXA",
  "&nbsp;&nbsp;&nbsp;[&nbsp;&nbsp;RXR&nbsp;&nbsp;]",
  "&nbsp;&nbsp;&nbsp;[{",
  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OBX",
  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[{&nbsp;PRT&nbsp;}]",
  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[{&nbsp;NTE&nbsp;}]",
  "&nbsp;&nbsp;&nbsp;}]",
  "}]"
]

rows = V2Web::Table[1377].rows
rows.shift
rows.each_with_index do |row, i|
  ChangeTracker.start
  txt = row.cells.first.content.first
  txt.content_content = vals[i]
  txt.save
  ChangeTracker.commit
end
