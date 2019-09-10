module Gui
  class HL7v2Controller < Gui::Controller
    map '/hl7v2/'
    layout('default') { |path, wish| !request.xhr? }
    
    def index
    end
    
    def prototype
      specs   = []
      specs << add_spec('documents', nil, :expanded => true)
      # specs << Gui::Director.new.render(nil, nil, :Collection, :Summary, MyDevice::PCDProfile)
      @documents = render_specs(specs, 'Documents')
    end
    
    def components
      raw_redirect('/')
    end
    
    def generate_datatype_page(opt = nil)
      datatypes_doc = SDoc::Document.where(Sequel.ilike(:title, '%DataType%')).last
      respond(datatypes_doc.to_hl7_site)
    end
    def generate_conformance_page(opt = nil)
      conformance_doc = SDoc::Document.where(Sequel.ilike(:title, '%Conformance%')).last
      respond(conformance_doc.to_hl7_site)
    end
    
    # FIXME put these somewhere else, like gui_widgets or gui_director
    def add_spec(getter, view_name = nil, options = {})
      @home  ||= Gui::Home.new
      @props ||= Gui::Home.properties
      view_name ||= :Summary
      view_type = options[:view_type] || :Collection
      # indexing into properties by getter is not foolproof.  we should be alright here due to the way that Gui::Home#add_method works.
      klass = @props[getter.to_sym][:class].to_const
      options[:label] ||= klass.to_title.pluralize
      spec = Gui::Director.new.render(@home, getter, view_type, view_name, klass, options)
      counter = 1
      # spec.each_line {|l| puts "#{counter}: #{l}"; counter += 1}; puts "*"*20
      spec
    end
    
    def render_specs(specs, title = nil)
      locals = {:page_title => title}
      rendered_specs = MainController.render_view(:object_wrapper, :output => specs.join("\n"), :breadcrumbs => [], :locals => locals) { |action| action.options[:is_layout] = true }
      counter = 1
      # rendered_specs.each_line {|l| puts_green "#{counter}: #{l}"; counter += 1}
      rendered_specs
    end
    
  end
end
