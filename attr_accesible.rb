module Kernel
  def attr_accessible(*attrs)
    attrs.each do |attr|
      define_method(attr) { instance_variable_get("@#{attr}") }
      define_method("#{attr}=") { |value| instance_variable_set("@#{attr}", value) }
    end
  end
end

MyClass = Class.new do
  attr_accessible :lol, :wut
end

my_obj = MyClass.new
my_obj.lol = 1
my_obj.wut = 2

puts my_obj.inspect
