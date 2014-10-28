module Hay
  class Task
    class Exception < StandardError
      def initialize(cause)
        @cause = cause
      end

      attr_accessor :cause
    end
  end
end
