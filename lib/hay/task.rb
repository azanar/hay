require 'hay'

require 'hay/task/flow'

module Hay
  ##
  # An Hay::Task is made up of a Task, and that Task's associated Flow.
  #
 class Task
    def initialize(template, instance)
      @template = template
      @instance = instance
    end

    def call(dispatcher)
      @instance.call(dispatcher)
    end

    attr_reader :template
    attr_reader :instance
    attr_writer :flow

    def flow
      @flow ||= Hay::Task::Flow::Node::List.new
    end

    def dehydrate
      {
        "name" => @task_name,
        "task" => @instance.dehydrate,
        "flow" => flow.dehydrate
      }
    end
  end
end
