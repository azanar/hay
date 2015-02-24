require 'hay'
require 'hay/task/template'

require 'hay/task/exception/unknown_template_error'

module Hay
  class Resolver
    class Catalog
      class Inflator
        def initialize(catalog)
          @catalog = catalog
        end

        def inflate(task)
          if @catalog.exists?(task)
            @catalog.find(task)
          else
            raise "Unable to find cataloged task #{task.inspect}"
          end
        end
      end

      def initialize
        @templates = {}
        @names = {}
      end

      def add(name, template)
        unless template.kind_of?(Hay::Task::Template)

        end
        @templates[name] = template
        @names[template] = name
      end

      def name(template)
        @names[template]
      end

      def exists?(name)
        @templates.has_key?(name)
      end

      def find(name)
        unless exists?(name)
          raise Hay::Task::Exception::UnknownTemplateError.new(name.inspect)
        end
        @templates[name]
      end
    end
  end
end
