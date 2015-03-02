require 'hay/route'

module Hay
  class Message
    def initialize(consumer, task)
      @consumer = consumer
      @task = task
      if @task.class == Hash
        raise "god damn it all #{@task}"
      end
    end

    def destination
      Hay::Route.new(nil)
    end

    attr_reader :task

    def payload
      @payload ||= @task.dehydrate
    end

    private

    def build_destination
      @consumer.for_name(@task.task_name) or raise "Could not find route for task #{@task.task_name}"
    end
  end
end
