require_relative "test"

module RSpec
  class Context
    def initialize(&)
      @runnables = []
      instance_eval(&)
    end

    def describe(_context = nil, &)
      @runnables << Context.new(&)
    end

    def it(_assertion = nil, &)
      @runnables << Test.new(&)
    end

    def call
      @runnables.each(&:call)
    end

    alias context describe
  end
end
