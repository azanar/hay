require 'punchout'
require 'punchout/matcher/ancestry'

module Hay
  class Task
    module Resolver
      include Punchout::Punchable

      def register(type, resolver)
        Hay.logger.info "Registering resolver #{type} for #{resolver}"
        matchable = Punchout::Matcher::Ancestry.new(type).punches(resolver)
        puncher.add(matchable)
      end
    end
  end
end

require 'hay/task/resolver/hash'
require 'hay/task/resolver/task'

