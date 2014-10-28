require 'hay/task/exception'

module Hay
  class Task
    class Exception < StandardError
      class TransientException < Hay::Task::Exception
      end
    end
  end
end
