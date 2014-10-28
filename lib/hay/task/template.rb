require 'hay'

require 'hay/task/templates'
require 'hay/task/exception/unknown_template_error'

module Hay
  class Task
    module Template
      def self.new(params)
        template_class = Hay::Task::Templates.for(params)
        if template_class.nil?
          raise Hay::Task::Exception::UnknownTemplateError.new("No template for #{params.class}")
        end
        template_class.new(params)
      end
    end
  end
end
