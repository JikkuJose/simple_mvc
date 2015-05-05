require 'tilt/haml'
require 'ostruct'

module SimpleMVC
  class Controller
    attr_reader :request, :params

    def initialize(env)
      @request = Rack::Request.new env
      @params = @request.params
    end

    def response
      Rack::Response.new(body, status, content_type)
    end

    def body
      render("#{action}.haml")
    end

    def status
      200
    end

    def action
      @request.path_info.split("/").reject { |element| element.empty? }.last
    end

    def content_type
      {"Content-Type" => "text/plain"}
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
