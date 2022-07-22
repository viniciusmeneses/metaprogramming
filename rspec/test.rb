require_relative "assert"
require_relative "matchers"

module RSpec
  class Test
    include Matchers

    def initialize(&)
      @assertions = []
      instance_eval(&)
    end

    def expect(value)
      assert = Assert.new(value)
      @assertions << assert
      assert
    end

    def call
      @assertions.each(&:call)
    end
  end
end
