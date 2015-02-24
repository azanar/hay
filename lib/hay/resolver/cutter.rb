require 'hay/resolver/cutter'

require 'hay/resolver/cutter/task'
require 'hay/resolver/cutter/template'

module Hay
  class Resolver
    class Cutter
      def initialize(templateish)
        @templateish = templateish
        cutter_klass = cutter_map[templateish.class]
        unless cutter_klass
          raise
        end
        @cutter = cutter_klass.new(templateish)
      end

      def cut
        @cutter.render
      end

      private 

      def cutter_map
        {
         Hay::Task => Hay::Resolver::Cutter::Task,
         Hay::Task::Template => Hay::Resolver::Cutter::Template
        }
      end
    end
  end
end

