def check_dt_depth(dt)
  depth = [dt.code]
  dt.components.each do |c|
    cdt = c.type
    next unless cdt
    depth << check_dt_depth(cdt)
  end
  depth
end
def depth (a)
  return 0 unless a.is_a?(Array)
  return 1 + a.collect{|b| depth(b)}.max
end
dts = {}
HL7::DataType.each do |dt|
  dts[dt.code] = check_dt_depth(dt)
end
dts.each {|dt, arr|
  arr = Array.new(arr.select {|a| depth(a) > 3 })
}

bdts = dts.select {|dt, arr|  puts arr.first + ' ' + depth(arr).to_s; depth(arr) > 2 }
pp bdts
puts bdts.count
# dts.each  {|dt, arr| puts "#{dt} - #{depth(arr)}"}