module Ikat
  module Utilities
    def self.transform_hash(original, options = {}, &block)
      original.inject({}) { |result, (key, value)|
        value = if (options[:deep] && Hash === value)
          transform_hash(value, options, &block)
        else
          if Array === value
            value.map { |v| transform_hash(v, options, &block) }
          else
            value
          end
        end

        block.call(result, key, value)

        result
      }
    end
  end
end
