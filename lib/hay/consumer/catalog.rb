require 'hay'

require 'hay/task/templates'
require 'hay/task/exception/unknown_template_error'

module Hay
  class Consumer
    class Catalog
      class Inflator
        def initialize(catalog)
          @catalog = catalog
        end

        def inflate(task)
          if catalog.exists?(task)

          end
        end
      end

      def initialize(consumer)
        @consumer = consumer
        @templates = {}
      end

      def add(name, template)
        @templates[name] << template
      end

      def exists?(name)
        @templates.has_key?(name)
      end

      def find(name)
        unless exists?(name)
          raise Hay::Task::Exception::UnknownTemplateError.new("No template for #{name}")
        end
        @templates[name]
      end
    end
  end
end
