module Hay
  class Task
    # Everything that wants to be a Task within the Hay system needs to mix
    # this module in.
    module Instance
      def initialize(params)
        @params = params
      end

      def dehydrate
        @params
      end

      def to_hay(consumer)
        Hay::Task.new(nil, self)
      end

      def call(dispatcher)
        raise NotImplementedError
      end
    end
  end
end

