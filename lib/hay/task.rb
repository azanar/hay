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
    module Autowired
      def self.included(base)
        base.instance_exec do
          include Hay::Task
        end
        Hay::Tasks.register(base)
        Hay::Task::Hydrators.register(base, Hay::Task::Hydrator)
      end
    end

    def task_name
      self.class.task_name
    end

    def process(dispatcher)
      raise NotImplementedError
    end

    def dehydrate
      raise NotImplementedError
    end

    def to_hay
      Hay::Task::Decorator.new(self)
    end
  end
end
