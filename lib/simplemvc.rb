require "simplemvc/version"

module SimpleMVC
  class Application
    def call(env)
      [200, {"Content-Type" => "text/html"}, ['Hey, there! Its SimpleMVC']]
    end
  end
end
