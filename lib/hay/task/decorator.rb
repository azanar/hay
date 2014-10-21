require 'delegate'

module Hay
  module Task
    class Decorator < SimpleDelegator 


      def initialize(obj)
        super
      end

      attr_writer :flow

      def flow
        @flow ||= Hay::Task::Flow.new
      end

      def dehydrate
        {
          "name" => task_name,
          "task" => super,
          "flow" => flow.dehydrate
        }
      end

      def process(dispatcher)
        resulter = Hay::Task::Resulter.new(flow, dispatcher)
        super(resulter)
      end
    end
  end
end

require 'hay/task/flow'
require 'hay/task/resulter'
