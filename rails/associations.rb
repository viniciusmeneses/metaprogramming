class ActiveRecord
  class Base
    class HasManyAssociation
      include Enumerable

      def initialize(klass, collection)
        @klass = klass
        @collection = collection
      end

      def each(&block)
        @collection.each(&block)
      end

      def <<(item)
        @collection << item
      end

      def find(item_id)
        @collection.find { |item| item.id == item_id }
      end

      def build(**args)
        @collection << @klass.new(**args)
      end

      def delete(item)
        @collection.delete(item)
      end
    end

    def self.belongs_to(name, **)
      define_method(name) { instance_variable_get("@#{name}") }
      define_method("#{name}=") { |value| instance_variable_set("@#{name}", value) }
    end

    def self.has_many(name, klass:)
      define_method(name) do
        instance_variable_get("@#{name}") || public_send("#{name}=", [])
      end

      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", HasManyAssociation.new(klass, value))
      end
    end
  end
end

Portfolio = Class.new(ActiveRecord::Base)
Milestone = Class.new(ActiveRecord::Base)

class Project < ActiveRecord::Base
  belongs_to :portfolio, klass: Portfolio
  has_many :milestones, klass: Milestone
end

obj = Project.new
obj.milestones << Milestone.new
obj.milestones.build
puts obj.milestones.to_a