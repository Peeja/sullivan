module Sullivan
  def self.validation(&block)
    DSL.new.instance_eval(&block)
  end

  class DSL < BasicObject
    def method_missing(method_name, *args)
      constant_name = ::ActiveSupport::Inflector.camelize(method_name)

      if ::Sullivan::Validations.const_defined?(constant_name)
        klass = ::Sullivan::Validations.const_get(constant_name)
        klass.new(*args)
      else
        super
      end
    end
  end
end

require_dependency 'sullivan/validations/boolean.rb'
require_dependency 'sullivan/validations/hash.rb'
require_dependency 'sullivan/validations/kind_of.rb'
require_dependency 'sullivan/validations/many.rb'
require_dependency 'sullivan/validations/optional.rb'
require_dependency 'sullivan/validations/string_matching.rb'
