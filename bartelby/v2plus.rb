module V2Plus
  module_function
  def web_output_dir
    File.expand_path('~/projects/v2demo/views')
  end
  def web_templates
    File.expand_path('~/projects/v2web/v2templates')
  end
  def get_web_template(type,name)
    File.expand_path(File.join('~/projects/v2web/v2templates', type.to_s, name.to_s + '.haml'))
  end
  def read_web_template(type,name)
    File.read(get_web_template(type,name))
  end
  def render_with_locals(type, name, locals)
    # locals[:draft] = @@draft ? true : false
    engine = Haml::Engine.new(read_web_template(type,name))
    output = engine.render(Object.new, locals)
  end
  def save_web_file(url, content)
    page = render_v2plus_page(content)
    File.open(File.join(web_output_dir, url), 'w+') {|f| f.puts page }
  end
  def render_v2plus_page(content)
    locals = {:content => content, :navbar_items => navbar_items}
    render_with_locals(:v2plus, :main, locals)
  end
  def navbar_items
    [
      ['index.html', 'Home'],
      ['tab.html', 'Vocabulary'],
      ['ctrl.html', 'Control'],
      ['encoding.html', 'Encoding'],
      ['transport.html', 'Transport'],
      ['dt.html', 'Data Types'],
      ['msg.html', 'Message Structures'],
      ['seg.html', 'Segments'],
      ['dom.html', 'Domains'],
      ['profile.html', 'Profiling'],
      ['dt_flav.html', 'Data Type Flavors'],
      ['v2x.html', 'v2.x']
    ]
  end
  # def create_site_file(local_url)
  #   location =
  #   puts "Creating site file at #{location}"
  #   File.open(location, 'w+') { |f| f.puts render_site(content) }
  # end
end
