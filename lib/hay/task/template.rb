require 'hay/task'

module Hay
  class Task
    class Template
      def initialize(name, instance, params = {})
        @name = name
        @instance = instance
        @params = params
      end

      def merge(params = {})
        self.new(@name, @instance, @params.merge(params))
      end

      def render
        @instance.new(@params)
      end
    end
  end
end
