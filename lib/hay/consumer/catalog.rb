require 'hay'

require 'hay/task/templates'
require 'hay/task/exception/unknown_template_error'

module Hay
  class Consumer
    class Catalog
      def initialize
        @tasks = []
      end

      def add(task)
        @tasks << task
      end

      def find(params)
        template_class = Hay::Task::Templates.for(params)
        if template_class.nil?
          raise Hay::Task::Exception::UnknownTemplateError.new("No template for #{params.class}")
        end
        template_class.new(params)
      end
    end
  end
end
