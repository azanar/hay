require 'punchout'
require 'punchout/matcher/ancestry'

module Hay
  class Task
    module Templates
      extend Punchout::Punchable

      def self.register(type, template)
        Hay.logger.info "Registering template #{type} for #{template}"
        matchable = Punchout::Matcher::Ancestry.new(type).punches(template)
        puncher.add(matchable)
      end

      def self.for(type)
        punch(type)
      end
    end
  end
end

require 'hay/task/template/hash'
require 'hay/task/template/task'
