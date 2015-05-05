require 'tilt/haml'
require 'ostruct'

module SimpleMVC
  class Controller
    attr_reader :request, :params

    def initialize(request)
      @request = request
      @params = request.params
    end

    def render(view)
      template = Tilt.new view_file(view)
      template.render self
    end

    def view_file(view)
      "app/views/#{controller_name}/#{view}"
    end

    def controller_name
      self.class.name.
        gsub(/Controller/, '').
        downcase.
        gsub(/^.*::/, '')
    end
  end
end
