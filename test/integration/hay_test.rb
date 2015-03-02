require File.expand_path('../../unit/test_helper', __FILE__)

require 'hay/consumer'
require 'hay/route'
require 'hay/task'
require 'hay/task/flow/node/hydrated'

require 'hay/task/instance'

class HayTest < Test::Unit::TestCase
  module MockTask
    def self.included(base)
      base.instance_exec do
        include Hay::Task::Instance

        def call(dispatcher)
          puts self.class.name
          Hay.logger.error "Hey! This task didn't implement a call method! #{self.class.name}"
          super
        end
      end
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

    def call(dispatcher)
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

    def call(dispatcher)
      dispatcher.push(TerminalTask.new.to_hay(@consumer))
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

    def call(dispatcher)
      dispatcher.push(RemoteTask.new.to_hay(@consumer))
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

    def call(dispatcher)
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
  end

  setup do
    @agent = Agent.new
    @consumer = Hay::Consumer.new(@agent)

    catalog = @consumer.catalog
    template = Hay::Task::Template.new(TerminalTask)
    catalog.add('terminal_task', template)
  end

  test 'consuming' do

    task = TerminalTask.new.to_hay(@consumer)

    @consumer.push(task)

    assert task.instance.ran
    assert_equal 0, @agent.messages.length
  end

  test 'consuming dehydrated' do
    task = TerminalTask.new.to_hay(@consumer)

    @consumer.push(task.dehydrate)

    assert_equal 0, @agent.messages.length
  end

  test 'consuming and injecting local' do
    task = InjectingLocalTask.new.to_hay(@consumer)

    @consumer.push(task)

    assert task.instance.ran
    assert_equal 0, @agent.messages.length
  end

  test 'consuming and injecting remote' do
    task = InjectingRemoteTask.new.to_hay(@consumer)

    @consumer.push(task)

    assert task.ran
    assert_equal 1, @agent.messages.length
    assert_kind_of RemoteTask, @agent.messages.first.task.__getobj__
  end

  test 'consuming and flowing' do
    terminal_task = RemoteTask.new.to_hay(@consumer)
    terminal_task_template = Hay::Task::Template.new(terminal_task)
    flow = Hay::Task::Flow::Node::Hydrated.new([terminal_task_template])

    task = FlowableTask.new.to_hay(@consumer)
    task.flow = flow

    @consumer.push(task)

    assert task.ran
    assert_equal 1, @agent.messages.length
    assert_kind_of RemoteTask, @agent.messages.first.task.__getobj__
    assert_kind_of Hay::Task::Decorator, @agent.messages.first.task
  end

  test 'consuming and flowing dehydrated' do
    terminal_template = Hay::Task::Template.new(RemoteTask)
    @consumer.catalog.add('terminal_task', terminal_template)
    flow = Hay::Task::Flow::Node::List.new([terminal_template])

    task = FlowableTask.new.to_hay(@consumer)
    task.flow = flow

    dtask = task.dehydrate

    puts "DEHYDRATED #{dtask}"

    @consumer.push(dtask)

    assert_equal 1, @agent.messages.length
    assert_kind_of RemoteTask, @agent.messages.first.task.__getobj__
    assert_kind_of Hay::Task::Decorator, @agent.messages.first.task
  end
end
