require 'hay/routes'

module Hay
  class Message
    def initialize(task)
      @task = task
      if @task.class == Hash
        raise "god damn it all #{@task}"
      end
    end

    attr_reader :task

    def payload
      @payload ||= @task.dehydrate
    end

    def destination
      @destination ||= build_destination
    end

    private

    def build_destination
      Hay::Routes.for_name(@task.task_name) or raise "Could not find route for task #{@task.task_name}"
    end
  end
end
