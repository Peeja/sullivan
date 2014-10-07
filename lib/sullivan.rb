module Sullivan
  def self.validation(&block)
    DSL.new.instance_eval(&block)
  end

  class DSL < BasicObject
    def method_missing(method_name, *args)
      constant_name = DSL.camelize(method_name.to_s)

      if ::Sullivan::Validations.const_defined?(constant_name)
        klass = ::Sullivan::Validations.const_get(constant_name)
        klass.new(*args)
      else
        super
      end
    end

    def self.camelize(string)
      string.split('_').map(&:capitalize).join
    end
  end
end

require 'sullivan/validations/hash.rb'
require 'sullivan/validations/kind_of.rb'
require 'sullivan/validations/many.rb'
require 'sullivan/validations/optional.rb'
require 'sullivan/validations/string_matching.rb'
