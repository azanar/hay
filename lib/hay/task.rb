require 'hay'

require 'hay/task/decorator'
require 'hay/task/hydrator'
require 'hay/task/hydrators'
require 'hay/tasks'

module Hay
  ##
  # An Hay::Task is made up of a Task, and that Task's associated Flow.
  #
  # A Task is any object that can respond to task_name, process, and
  # dehydrate.
  #
  module Task
    def self.included(base)
      Hay::Tasks.register(base)
      Hay::Task::Hydrators.register(base, Hay::Task::Hydrator)
    end

    def task_name
      self.class.task_name
    end

    def to_hay
      Hay::Task::Decorator.new(self)
    end
  end
end
