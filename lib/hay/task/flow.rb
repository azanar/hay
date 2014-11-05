require 'hay'

module Hay
  class Task
    module Flow
      class List
        include Enumerable

        def initialize(list = [])
          templates = list || []

          unless templates.kind_of?(Array)
            raise "This has to be an array, dude!"
          end

          @templates = templates.map do |t|
            Hydrated.new(t)
          end
        end

        def each
          @templates.each do |t|
            yield t
          end
        end
      end

      def initialize(template)
        @template = template
      end

      class Dehydrated
        include Flow

        def inflate(catalog)
          inflator = catalog.inflator
          template = inflator.inflate(@template[:name])

          Hydrated.new(template)
        end
      end
      class Hydrated
        include Flow

        def dehydrate
          Hay.logger.debug("Dehydrating #{@template.inspect}")
          d = @template.dehydrate 

          Dehydrated.new(d)
        end
      end
    end
  end
end
