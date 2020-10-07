class Tester
  STUFF = {'a' => '1', 'b' => '2', 'c' => '3', 'd' => '4', 'e' => '5'}
  def method1(str)
    str.gsub!(/#{STUFF.keys.join('|')}/) { |m| STUFF[m] }
  end
  def method2(str)
    STUFF.each do |k,v|
      str.gsub!(/#{k}/, v)
    end
  end
  
end

t = Tester.new
str = "The quick brown fox jumps over the lazy dog"
time = Time.now
100000.times { t.method1(str) }
puts "method1 took #{Time.now - time} seconds"
time = Time.now
100000.times { t.method2(str) }
puts "method2 took #{Time.now - time} seconds"


    