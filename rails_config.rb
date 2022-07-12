class TestApp
  class Application
    class Config
      def method_missing(method, *args)
        setting = method.to_s.chomp("=")

        define_singleton_method("#{setting}=") do |value|
          instance_variable_set("@#{setting}", value)
        end

        define_singleton_method(setting) do
          instance_variable_get("@#{setting}")
        end

        public_send(method, *args)
      end
    end

    @config = Config.new

    def self.configure(&block)
      instance_eval(&block)
    end

    def self.config
      @config
    end
  end
end

TestApp::Application.configure do
  config.cache_classes = true
  config.action_controller = true
end

puts TestApp::Application.config.cache_classes

TestApp::Application.configure do
  config.cache_classes = false
end

puts TestApp::Application.config.cache_classes
puts TestApp::Application.config.action_controller
