module RSpec
  class Matcher
    def initialize(method = nil, value = nil, &block)
      @block = block_given? ? block : -> (other_value) { value.send(method, other_value) }
    end

    def call(other_value)
      @block.call(other_value)
    end
  end
end
