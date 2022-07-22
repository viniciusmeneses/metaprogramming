module RSpec
  class Assert
    def initialize(value)
      @value = value
    end

    def to(matcher)
      @result = matcher.call(@value)
    end

    def to_not(matcher)
      @result = !matcher.call(@value)
    end

    def call
      throw "error" unless @result
    end

    alias not_to to_not
  end
end
