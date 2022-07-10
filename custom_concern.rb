
module Custom
  module Concern
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def in_class(&block)
        @included_block = block
      end

      def class_methods(&block)
        @class_methods_block = block
      end

      def included(base)
        base.class_eval &@included_block

        # Create a ClassMethods module inside the module which Custom::Concern was included
        const_set(:ClassMethods, Module.new)
        # Evaluate block in the created module context
        const_get(:ClassMethods).module_eval &@class_methods_block
        # Extend the class with inner ClassMethods module to allow access to the methods
        base.extend const_get :ClassMethods
      end
    end
  end
end

module MyModule
  include Custom::Concern

  def instance_method
    "instance method"
  end

  in_class do
    attr_accessor :foo
  end

  class_methods do
    def class_method
      "class method"
    end
  end
end

class MyClass
  include MyModule
end

puts MyClass.instance_methods(false)
puts MyClass.class_method
puts MyClass.new.instance_method
