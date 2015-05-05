require "simple_mvc/version"
require "simple_mvc/controller"

module SimpleMVC
  class Application
    attr_reader :request

    def call(env)
      @env = env

      response
    end

    def response
      c = controller.new Rack::Request.new(@env)
      c.send action
      body = c.render("#{action}.haml")

      Rack::Response.new(body, 200, {"Content-Type" => "text/html"})
    end

    def action
      path_info.last.to_sym
    end

    def controller
      require "#{controller_name}_controller"
      Object.const_get controller_symbol
    end

    private

    def path_info
      @env["PATH_INFO"].split("/").reject { |element| element.empty? }
    end

    def controller_name
      path_info.first
    end

    def controller_symbol
      encapsulating_module +
        "::" +
        controller_name.capitalize +
        "Controller"
    end

    def encapsulating_module
      self.class.ancestors.first.to_s.split("::").first
    end
  end
end
