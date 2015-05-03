require "simple_mvc/version"
require "simple_mvc/utils"
require "simple_mvc/dependencies"
require "simple_mvc/controller"

module SimpleMVC
  class Application
    def call(env)
      @env = env
      [200, {"Content-Type" => "text/html"}, [response]]
    end

    def response
      controller.new.send action
    end

    def path_info
      @env["PATH_INFO"].split("/").reject { |element| element.empty? }
    end

    def controller
      controller_name = path_info.first
      controller_symbol = (encapsulating_module +
                           "::" +
                           controller_name.capitalize +
                           "Controller")

      require "#{controller_name}_controller"
      Object.const_get controller_symbol
    end

    def action
      path_info.last.to_sym
    end

    def encapsulating_module
      self.class.ancestors.first.to_s.split("::").first
    end
  end
end
