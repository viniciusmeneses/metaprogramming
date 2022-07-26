module RSpec
  module Matchers
    def eq(value)
      -> (other_value) { value == other_value or throw "failed" }
    end
  end
end
