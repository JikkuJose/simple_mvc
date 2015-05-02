require 'tilt/haml'

module SimpleMVC
  class Controller
    def render(view)
      template = Tilt.new view_file(view)
      template.render
    end

    def view_file(view)
      controller_name = self.class.name.
        gsub(/Controller/, '').
        downcase.
        gsub(/^.*::/, '')
      "app/views/#{controller_name}/#{view}"
    end
  end
end
