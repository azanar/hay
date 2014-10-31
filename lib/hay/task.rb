require 'hay'

require 'hay/task/flow'
require 'hay/task/template/task'

module Hay
  ##
  # An Hay::Task is made up of a Task, and that Task's associated Flow.
  #
  class Task
    def initialize(instance)
      @instance = instance
    end

    def process(dispatcher)
      @instance.call(dispatcher)
    end

    attr_writer :flow

    def flow
      @flow ||= Hay::Task::Flow.new
    end

    def template
      Hay::Task::Template::Task.new
    end

    def dehydrate
      {
        "name" => @task_name,
        "task" => @task.params,
        "flow" => flow.dehydrate
      }
    end
  end
end
