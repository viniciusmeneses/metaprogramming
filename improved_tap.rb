class Object
  def improved_tap(&block)
    instance_eval(&block)
    self
  end
end

class MyClass
  def initialize
    @var = "instance var"
  end

  def foo
    "MyClass#foo"
  end
end

obj = MyClass.new
obj.improved_tap { puts @var }.foo
