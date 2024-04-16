module WriteAdoc
  module_function
  
  def local_output_dir
    dir = File.expand_path('output', __dir__)
    FileUtils.mkdir_p(dir) unless File.exist?(dir)
    dir
  end
  
  def destination_output_dir
    absolute_output_dir
    dir = File.expand_path(File.join(project_dir, 'v2plus_html'), __dir__)
    FileUtils.mkdir_p(dir) unless File.exist?(dir)
    dir
  end
  
  def local_outputify(path)
    _outputify(path, local_output_dir)
  end
  
  def destination_outputify(path)
    _outputify(path, destination_output_dir)
  end
  
  def _outputify(path, dest_dir)
    html_path = path.sub(git_dir, dest_dir).sub(/adoc$/, 'html')
    ensure_dir_exists_for_file(html_path)
    html_path
  end
  
  def ensure_dir_exists_for_file(filename)
    dir = File.dirname(filename)
    FileUtils.mkdir_p(dir) unless File.exist?(dir)
  end

  def docinfo_file
    File.expand_path('docinfo.html', __dir__)
  end
  
  def css_dir
    File.expand_path('assets/css', __dir__)
  end
  
  def js_dir
    File.expand_path('assets/js', __dir__)
  end

  def images_dir
    File.expand_path('assets/images', __dir__)
  end
  
  def git_dir
    @git_dir ||= File.expand_path(File.join(project_dir, 'v2plus_adoc_source'), __dir__)
    FileUtils.mkdir_p(@git_dir) unless File.exist?(@git_dir)
    @git_dir
  end
  
  def project_dir
    @project_dir ||= File.expand_path('../../..', __dir__)
  end
    
  def absolute_output_dir
    @aod ||= File.expand_path(File.join(project_dir, 'v2plus_html'), __dir__)
    FileUtils.mkdir_p(@aod) unless File.exist?(@aod)
    # puts Rainbow(@aod).gold
    @aod
  end

end
