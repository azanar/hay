require 'hay'

module Hay
  class Task
    module Flow
      def initialize(list = [])
        @templates = list || []

        unless @templates.kind_of?(Array)
          raise "This has to be an array, dude!"
        end
      end

      class Dehydrated
        include Flow

        def inflate(catalog)
          inflator = catalog.inflator
          templates = @templates.map do |t|
            template = inflator.inflate(t[:name])

            if template.nil?

            end
          end

          Hydrated.new(templates)
        end
      end
      class Hydrated
        include Flow

        def dehydrate
          templates = @templates.map do |n| 
            Hay.logger.debug("Dehydrating #{n.inspect}")
            n.dehydrate 
          end

          Dehydrated.new(templates)
        end
      end
    end
  end
end
