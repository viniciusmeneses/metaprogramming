module RSpec
  class Assert
    def initialize(value)
      @value = value
    end

    def to(matcher)
      matcher.call(@value)
    end

    def to_not(matcher)
      !matcher.call(@value)
    end

    alias not_to to_not
  end
end
