class OtherStruct
  def self.new(*attrs, &block)
    Class.new do
      attr_accessor(*attrs)

      class_eval(&block) if block

      # @attrs = attrs
      # def initialize(*values)
      #   values.each.with_index { |value, index| send("#{self.class.attrs[index]}=", value) }
      # end
      #
      # def self.attrs
      #   @attrs
      # end

      define_method(:initialize) do |*values|
        values.each.with_index { |value, index| instance_variable_set("@#{attrs[index]}", value) }
      end

      def [](attr)
        send(attr)
      end

      def []=(attr, value)
        send("#{attr}=", value)
      end
    end
  end
end

MyClass = OtherStruct.new(:a, :b) do
  def to_s
    "<#{self.class} a:#{a} b:#{b}>"
  end
end

obj = MyClass.new(1, 2)
obj[:a] = 5

puts obj.to_s
puts obj.inspect
puts obj["b"]
puts obj.b
