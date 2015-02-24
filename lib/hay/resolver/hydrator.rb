require 'hay/task/flow/hydrator'

module Hay
  class Resolver
    class Hydrator
      def initialize(catalog, taskish)
        hydrator_klass = hydrator_map[taskish.class]
        unless hydrator_klass
          raise
        end
        @hydrator = hydrator_klass.new(catalog, taskish)
      end

      def hydrate
        @hydrator.hydrate
      end

      private

      def hydrator_map
        {
          Hash => Hay::Resolver::Hydrator::Hash,
         Hay::Task => Hay::Resolver::Hydrator::Template,
         Hay::Task::Template => Hay::Resolver::Hydrator::Template 
        }
      end
    end
  end
end

require 'hay/resolver/hydrator/hash'
require 'hay/resolver/hydrator/template'
