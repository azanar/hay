require File.expand_path('../../unit/test_helper', __FILE__)

require 'hay/consumer'
require 'hay/route'
require 'hay/task'

require 'hay/task/templates'

class HayTest < Test::Unit::TestCase
  class Consumer
    include Hay::Consumer

    def tasks
      [TerminalTask]
    end
  end

  module MockTask
    def self.included(base)
      base.instance_exec do
        include Hay::Task::Autowired
      end
    end

    def payload
      {}
    end

    def self.task_name
      "outtask"
    end

    def dehydrate
      {}
    end
  end


  class RemoteTask
    def self.task_name
      "out_task"
    end

    include MockTask

    def initialize(params = {})
    end
  end

  class TerminalTask

    def self.task_name
      "terminal_task"
    end

    include MockTask

    def initialize(params = {})
      @ran = false
    end

    def process(dispatcher)
      @ran = true
    end

    attr_reader :ran
  end

  class InjectingLocalTask
    def initialize(params = {})
      @ran = false
    end

    def self.task_name
      "injecting_local_task"
    end

    include MockTask

    def process(dispatcher)
      dispatcher.inject(TerminalTask.new.to_hay)
      @ran = true
    end

    attr_reader :ran
  end

  class InjectingRemoteTask
    def initialize(params = {})
      @ran = false
    end

    def self.task_name
      "injecting_remote_task"
    end

    include MockTask

    def process(dispatcher)
      dispatcher.inject(RemoteTask.new.to_hay)
      @ran = true
    end

    attr_reader :ran
  end

  class FlowableTask
    def initialize(params = {})
      @ran = false
    end

    def self.task_name
      "flowable_task"
    end

    include MockTask

    def process(dispatcher)
      dispatcher.submit({})
      @ran = true
    end

    attr_writer :data
    attr_reader :ran
  end

  class Agent
    def initialize
      @messages = []
    end

    def publish(message)
      @messages << message
    end

    attr_reader :messages

  end

  class RemoteRoute
    def self.tasks
      [RemoteTask]
    end

    include Hay::Route::Autowired

  end

  test 'consuming' do
    agent = Agent.new

    consumer = Consumer.new(agent)

    task = TerminalTask.new.to_hay

    consumer.push(task)

    assert task.ran
    assert_equal 0, agent.messages.length
  end

  test 'consuming dehydrated' do
    agent = Agent.new

    consumer = Consumer.new(agent)

    task = TerminalTask.new.to_hay

    consumer.push(task.dehydrate)

    assert_equal 0, agent.messages.length
  end

  test 'consuming and injecting local' do
    agent = Agent.new

    consumer = Consumer.new(agent)

    task = InjectingLocalTask.new.to_hay

    consumer.push(task)

    assert task.ran
    assert_equal 0, agent.messages.length
  end

  test 'consuming and injecting remote' do
    agent = Agent.new

    consumer = Consumer.new(agent)

    task = InjectingRemoteTask.new.to_hay

    consumer.push(task)

    assert task.ran
    assert_equal 1, agent.messages.length
    assert_kind_of RemoteTask, agent.messages.first.task.__getobj__
  end

  test 'consuming and flowing' do
    agent = Agent.new

    consumer = Consumer.new(agent)

    terminal_task = RemoteTask.new.to_hay
    flow = Hay::Task::Flow.new([terminal_task])

    task = FlowableTask.new.to_hay
    task.flow = flow

    consumer.push(task)

    assert task.ran
    assert_equal 1, agent.messages.length
    assert_kind_of RemoteTask, agent.messages.first.task.__getobj__
    assert_kind_of Hay::Task::Decorator, agent.messages.first.task
  end

  test 'consuming and flowing dehydrated' do
    agent = Agent.new

    consumer = Consumer.new(agent)

    terminal_task = RemoteTask.new.to_hay
    flow = Hay::Task::Flow.new([terminal_task])

    task = FlowableTask.new.to_hay
    task.flow = flow

    dtask = task.dehydrate

    consumer.push(dtask)

    assert_equal 1, agent.messages.length
    assert_kind_of RemoteTask, agent.messages.first.task.__getobj__
    assert_kind_of Hay::Task::Decorator, agent.messages.first.task
  end
end
