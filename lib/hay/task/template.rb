require 'hay/task'

module Hay
  class Task
    class Template
      def initialize(instance, params = {})
        @instance = instance
        @params = params
        puts self.inspect
      end

      def merge(params = {})
        self.new(@instance, @params.merge(params))
      end

      def render
        @instance.new(@params)
      end
    end
  end
end
