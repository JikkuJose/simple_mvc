require_relative './test_helper.rb'
require 'simple_mvc'

class ClassName < Minitest::Test
  def test_default_config
    assert_equal SimpleMVC.config.language, :english
  end

  def test_initialization_via_hash
    app = SimpleMVC::Application.new({locale: :in})
    assert_equal app.config.locale, :in
  end

  def test_configure_method
    global_config = SimpleMVC.config
    assert_equal global_config.marshal_dump, {:language => :english}

    SimpleMVC.configure do |c|
      c.template = :haml
    end

    assert_equal global_config.marshal_dump, {language: :english, template: :haml}
  end
end

Minitest.autorun
