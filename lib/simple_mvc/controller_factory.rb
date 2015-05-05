module SimpleMVC
  class ControllerFactory
    def self.create(env)
      new(env).controller
    end

    def initialize(env)
      @env = env
    end

    def controller
      require snake_case
      Object.const_get full_name
    end

    private

    def name
      path_info.first
    end

    def full_name
      "#{SimpleMVC.config.app_name}::#{camel_case}"
    end

    def snake_case
      "#{name}_controller"
    end

    def camel_case
      "#{name.to_s.capitalize}Controller"
    end

    def path_info
      @env["PATH_INFO"].split("/").reject { |fragment| fragment.empty? }
    end
  end
end
