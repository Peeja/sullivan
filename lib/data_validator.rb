module DataValidator
  def self.validation(&block)
    DSL.new.instance_eval(&block)
  end

  class DSL < BasicObject
    def method_missing(method_name, *args)
      constant_name = ::ActiveSupport::Inflector.camelize(method_name)

      if ::DataValidator::Validations.const_defined?(constant_name)
        klass = ::DataValidator::Validations.const_get(constant_name)
        klass.new(*args)
      else
        super
      end
    end
  end
end

require_dependency 'data_validator/validations/boolean.rb'
require_dependency 'data_validator/validations/hash.rb'
require_dependency 'data_validator/validations/kind_of.rb'
require_dependency 'data_validator/validations/many.rb'
require_dependency 'data_validator/validations/optional.rb'
require_dependency 'data_validator/validations/string_matching.rb'
