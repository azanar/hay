require 'hay/task'

module Hay
  class Task
    module Template
      class Task
        def initialize(params)
          @name = params.task_name
          @payload = params.payload
          @flow = params.flow
        end

        def render(params = {})
          merged = params.merge(@payload)

          task = Hay::Task.new(@name)

          task.flow = @flow
          task
        end

        Hay::Task::Templates.register(Hay::Task, self)
      end
    end
  end
end

