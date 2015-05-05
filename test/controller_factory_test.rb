require_relative './test_helper.rb'
require 'controller_factory'

class ControllerFactoryTest < Minitest::Test
  def setup
    env = {"PATH_INFO" => "/pages/about"}
    @cf = SimpleMVC::ControllerFactory.new(env)
  end

  def test_action
    assert_equal :about, @cf.action
  end
end

Minitest.autorun
