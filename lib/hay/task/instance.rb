module Hay
  class Task
    module Instance
      module Autowired
        def self.included(base)
          base.instance_exec do
            include Hay::Task::Instance
          end
          Hay::Task::Processors.register(base.task_name, base)
        end
      end

      def initialize(params)
        @params = params
      end

      def to_hay
        Hay::Task.new(self)
      end

      def call(dispatcher)
        raise NotImplementedError
      end
    end
  end
end

