require 'hay/task/exception'

module Hay
  module Task
    class Exception < StandardError
      class TransientException < Hay::Task::Exception
      end
    end
  end
end
