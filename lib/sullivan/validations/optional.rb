module Sullivan
  module Validations
    class Optional
      def initialize(validation)
        @validation = validation
      end

      def validate(value)
        unless value.nil?
          error = @validation.validate(value)
          if error
            error.respond_to?(:to_str) ? "#{error.to_str}, if present" : error
          end
        end
      end
    end
  end
end
