require 'hay/task'

module Hay
  class Task
    class Template
      def initialize(name, params)
        @name = name
        @params = params
      end

      def render(params = {})
        merged = params.merge(@params)

        instance = type.new(merged)

        Hay::Task.new(instance)
      end
    end
  end
end
