module Hay
  module Tasks
    extend Punchout::Punchable
    def self.register(task)
      matchable = Punchout::Matcher::Equal.new(task.task_name).punches(task)
      puncher.add(matchable)
    end

    def self.for(task)
      punch(task)
    end

    def self.for_name(name)
      punch(name)
    end
  end
end

