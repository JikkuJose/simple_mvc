require "simple_mvc/version"
require "simple_mvc/controller"
require "simple_mvc/controller_factory"
require "ostruct"

module SimpleMVC
  @config = OpenStruct.new({language: :english})

  class Application
    attr_reader :config

    def initialize(config = {})
      @config = merge_configuration config
    end

    def call(env)
      @env = env

      ControllerFactory.create(env).new(env).response
    end

    def merge_configuration(config)
      OpenStruct.new SimpleMVC.config.marshal_dump.merge(config)
    end
  end

  def self.configure(&block)
    block.call(@config)
  end

  def self.config
    @config
  end
end
