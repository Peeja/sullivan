module DataValidator
  module Validations
    class Many
      def initialize(validation, at_least: nil, at_most: nil)
        @validation = validation
        @at_least   = at_least
        @at_most    = at_most
      end

      def validate(values)
        return 'must be an array' unless values.respond_to?(:map)
        return "must contain at least #{num_elements(@at_least)}" if @at_least && values.size < @at_least
        return "must contain at most #{num_elements(@at_most)}"   if @at_most  && values.size > @at_most

        errors = values.map do |value|
          @validation.validate(value)
        end

        errors unless errors.all?(&:nil?)
      end

      private

      def num_elements(n)
        "#{n} #{n == 1 ? 'element' : 'elements'}"
      end
    end
  end
end
