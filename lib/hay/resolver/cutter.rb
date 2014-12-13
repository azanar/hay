require 'hay/resolver/cutter'

module Hay
  class Resolver
    class Cutter
      def initialize(template)
        @template = template
      end

      def cut
        @template.render({})
      end
    end
  end
end

