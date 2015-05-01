require "simple_mvc/version"

module SimpleMVC
  class Application
    def call(env)
      @env = env
      [200, {"Content-Type" => "text/html"}, response]
    end

    def response
      controller.new.send action
    end

    def path_info
      @env["PATH_INFO"].split("/").reject { |element| element.empty? }
    end

    def controller
      controller_name = path_info.first
      controller = (controller_name.capitalize + "Controller").to_sym
      Object.const_get controller
    end

    def action
      path_info.last.to_sym
    end
  end
end
