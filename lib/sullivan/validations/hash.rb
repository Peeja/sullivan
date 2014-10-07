module Sullivan
  module Validations
    class Hash
      def initialize(validations)
        @validations = validations
      end

      def validate(hash)
        return 'must be a hash' unless hash.respond_to?(:to_hash)
        hash = hash.to_hash

        errors = @validations.each_with_object({}) { |(key, validation), h|
          error = validation.validate(hash[key])
          h[key] = error unless error.nil?
        }

        errors.merge! (hash.keys - @validations.keys).each_with_object({}) { |unexpected_key, h| h[unexpected_key] = 'is unexpected' }

        errors unless errors.empty?
      end
    end

    class StringHash < Hash
      def initialize(validations)
        super stringify_keys(validations)
      end

      private

      def stringify_keys(hash)
        hash.each_with_object({}) { |(k, v), h| h[k.to_s] = v }
      end
    end
  end
end
