module Sullivan
  module Validations
    class Boolean
      def validate(value)
        'must be a boolean value' unless [true, false, 'true', 'false'].include?(value)
      end
    end
  end
end
