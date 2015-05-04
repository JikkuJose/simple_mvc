require 'tilt/haml'
require 'ostruct'

module SimpleMVC
  class Controller
    def render(view)
      template = Tilt.new view_file(view)
      template.render OpenStruct.new(locals)
    end

    def locals
      instance_variables.each_with_object({}) do |v, hash|
        variable = v.to_s[1..-1].to_sym
        p variable
        hash[variable] = instance_variable_get v
      end
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
