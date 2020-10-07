# Hacky as crap but we didn't build this as a builder in the first place so...
module V2Web
  module_function
  
  def html_coder
    @html_coder ||= HTMLEntities.new
  end
  
  def section_by_number(num)
    @sections_by_number[num]
  end
  
  def sections_by_number
    @sections_by_number
  end
  
  def reset_sections
    @sections_by_number = {}
  end
  
  def set_section_number(sect, num)
    @sections_by_number[num] = sect
  end

  def footnotes
    @footnote_store ||= []
  end
  
  def footnote(number)
    @footnote_store.find { |fn| fn[:counter] == number}
  end
  
  def store_footnotes(fn)
    @footnote_store = fn
    # set_footnote_hash(fn)
  end
  
  def tables_by_id
    @tables_by_id
  end

  def tables_by_number
    @tables_by_number
  end
  
  def store_tables(tt)
    @tables_by_number = {}
    @tables_by_id     = {}
    tt.each do |t|
      @tables_by_id[t.id] = t
      if t.caption
        number = t.caption.strip.scan(/^Table\s+\d+\.\d+/).first&.delete('Table')&.strip
        puts t.caption.inspect unless number
        @tables_by_number[number] = t if number
      else
        puts "Table with no caption -- #{t.id}."
      end
    end
  end
  
  def figures_by_id
    @figures_by_id
  end

  def figures_by_number
    @figures_by_number
  end
  
  def store_figures(ff)
    @figures_by_number = {}
    @figures_by_id     = {}
    ff.each do |f|
      @figures_by_id[f.id] = f
      if f.caption
        number = f.caption.strip.scan(/^Figure\s+\d+\.\d+/).first&.delete('Figure')&.strip
        puts f.caption unless number
        @figures_by_number[number] = f
      else
        puts "Figure with no caption -- #{f.id}."
      end
    end
  end
end
