require 'hay'

require 'punchout/matcher/equal'

module Hay
  module Task
    module Hydrators
      extend Punchout::Punchable

      def self.register(task, hydrator)
        Hay.logger.info "Registering hydrator #{task.task_name} for #{hydrator}"
        matchable = Punchout::Matcher::Equal.new(task.task_name).punches(hydrator)
        puncher.add(matchable)
      end

      def self.for(params)
        if params['name'].nil?
          raise "No name in parameter list: #{params.inspect}"
        end
        hydrator = punch(params['name'])
        if hydrator.nil?
          raise "No hydrator for task name #{params["name"]}: #{self.puncher.inspect}"
        end
        hydrator.new(params)
      end
    end
  end
end
