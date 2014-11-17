module Hay
  class Task
    module Instance
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

