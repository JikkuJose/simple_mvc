require "simple_mvc/version"

module SimpleMVC
  class Application
    def call(env)
      [200, {"Content-Type" => "text/html"}, ['Hello, there! Its SimpleMVC']]
    end
  end
end
