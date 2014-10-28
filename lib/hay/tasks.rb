module Hay
  class Task
    class Processors
      extend Punchout::Punchable
      def self.register(name, processor)
        matchable = Punchout::Matcher::Equal.new(name).punches(processor)
        puncher.add(matchable)
      end

      def self.for(processor)
        punch(processor)
      end

      def self.for_name(name)
        punch(name)
      end
    end
  end
end

