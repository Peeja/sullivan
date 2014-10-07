module DataValidator
  module Validations
    class KindOf
      def initialize(klass)
        @klass = klass
      end

      def validate(value)
        unless value.kind_of?(@klass)
          "must be a kind of #{@klass}"
        end
      end
    end
  end
end
