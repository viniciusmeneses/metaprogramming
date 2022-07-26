require_relative "test"

module RSpec
  class Context
    def initialize(name: nil, hooks: nil, &block)
      @name = name
      @runnables = []

      @hooks = hooks || { before: [], after: [] }
      @ctx_hooks = { before: [], after: [] }

      instance_eval(&block)
    end

    def before(*args, &)
      register_hook(:before, *args, &)
    end

    def after(*args, &)
      register_hook(:after, *args, &)
    end

    def context(name = nil, &)
      @runnables << Context.new(name:, hooks: @hooks, &)
    end

    def it(name = nil, &)
      @runnables << Test.new(name:, hooks: @hooks, &)
    end

    def call
      puts "context #{@name}" if @name

      @ctx_hooks[:before].each(&:call)
      @runnables.each(&:call)
      @ctx_hooks[:after].each(&:call)
    end

    alias describe context

    private

    def register_hook(type, trigger = :example, &block)
      case trigger
      when :example then @hooks[type] << block
      when :all then @ctx_hooks[type] << block
      end
    end
  end
end
