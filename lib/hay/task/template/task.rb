require 'hay/task'

module Hay
  class Task
    module Template
      class Task
        def initialize(name, params)
          @name = name
          @params = params
        end

        def render(params = {})
          merged = params.merge(@params)

          type = Hay::Tasks.new(@name)

          instance = type.new(merged)

          Hay::Task.new(instance)
        end

        Hay::Task::Templates.register(Hay::Task, self)
      end
    end
  end
end

