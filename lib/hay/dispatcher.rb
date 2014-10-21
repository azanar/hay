require 'hay'

require 'hay/router'
require 'hay/message'

module Hay
  class Dispatcher
    def initialize(consumer, agent)
      @consumer = consumer
      @agent = agent
      @router = Hay::Router.new(@agent)
    end

    def push(task)
      if @consumer.ours?(task)
        @consumer.push(task)
      else
        message = Hay::Message.new(task)
        @router.push(message)
      end
    end
  end
end
