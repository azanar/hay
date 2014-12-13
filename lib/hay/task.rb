require 'hay'

require 'hay/task/flow'
#require 'hay/task/template/task'

module Hay
  ##
  # An Hay::Task is made up of a Task, and that Task's associated Flow.
  #
 class Task
    def initialize(instance)
      @instance = instance
    end

    def call(dispatcher)
      @instance.call(dispatcher)
    end

    attr_writer :flow

    def flow
      @flow ||= Hay::Task::Flow::Node::List.new
    end

    def template
      Hay::Task::Template::Task.new
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
