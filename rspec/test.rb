require_relative "assert"
require_relative "matchers"

module RSpec
  class Test
    include Matchers

    def initialize(name: nil, hooks:, &block)
      @name = name
      @block = block
      @hooks = hooks
    end

    def expect(value)
      Assert.new(value)
    end

    def call
      puts "it #{@name}" if @name

      @hooks[:before].each(&:call)
      instance_eval(&@block)
      @hooks[:after].each(&:call)
    end
  end
end
