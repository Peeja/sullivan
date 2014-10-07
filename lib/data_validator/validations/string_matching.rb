module DataValidator
  module Validations
    class StringMatching
      def initialize(regex, error: nil)
        @regex        = regex
        @custom_error = error
      end

      def validate(value)
        error unless value.respond_to?(:to_str) && value.to_str =~ @regex
      end

      private

      def error
        @custom_error || "must be a string matching #{@regex.inspect}"
      end
    end
  end
end
