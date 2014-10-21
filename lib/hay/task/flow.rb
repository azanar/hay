require 'hay'

require 'hay/task/template'

module Hay
  module Task
    class Flow
      def initialize(list = [])
        @tasks = list || []
        unless @tasks.kind_of?(Array)
          raise "This has to be an array, dude!"
        end
      end

      def push(tasks)
        tasks = Array(tasks)

        @tasks += tasks
      end

      def dehydrate
        @tasks.map do |n| 
          if n.kind_of?(Hash)
            Hay.logger.debug("Not dehydrating an already dehydrated #{n.inspect}")
            n
          else
            Hay.logger.debug("Dehydrating #{n.inspect}")
            n.dehydrate 
          end
        end
      end

      def inflate
        @tasks.map do |params| 
          Hay.logger.debug("Inflating #{params.inspect}")
          Hay::Task::Template.new(params)
        end
      end
    end
  end
end
