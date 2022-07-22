require_relative "matcher"

module RSpec
  module Matchers
    def eq(value)
      Matcher.new(:==, value)
    end
  end
end
