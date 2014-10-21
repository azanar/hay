require 'punchout'
require 'punchout/matcher/equal'

module Hay
  module Routes
    extend Punchout::Punchable

    def self.register(route)
      route.tasks.each do |task|
        matchable = Punchout::Matcher::Equal.new(task.task_name).punches(route)
        puncher.add(matchable)
      end
    end

    def self.for_task(task)
      punch(task.task_name)
    end

    def self.for_name(name)
      punch(name)
    end
  end
end

