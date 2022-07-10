class Module
  def alias_method_chain(original, extra)
    without_extra = "#{original}_without_#{extra}"
    alias_method without_extra, original
    with_extra = "#{original}_with_#{extra}"
    alias_method original, with_extra
  end

  private :alias_method_chain
end

class MyClass
  def foo
    "it was foo"
  end

  def foo_with_extra
    "it was foo_with_extra"
  end

  alias_method_chain :foo, :extra
end

puts MyClass.instance_methods(false)
