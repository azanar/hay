require File.expand_path('../../test_helper', __FILE__)

require 'hay/task'
require 'hay/task/flow/node/list'
require 'hay/task/flow/node/dehydrated'
require 'hay/task/flow/node/hydrated'
require 'hay/task/instance'
require 'hay/task/resulter'
require 'hay/task/template'

class Hay::Task::IntegrationTest < Test::Unit::TestCase
  class MockTask
    include Hay::Task::Instance

    def call(resulter)
      resulter.submit('foo')
    end
  end

  class InjectedTask
    include Hay::Task::Instance

    def call(resulter)
      resulter.submit('foo')
    end
  end

  test 'inflated' do
    template = Hay::Task::Template.new(MockTask)

    instance = template.render

    task = Hay::Task.new(instance)

    flow_template = Hay::Task::Template.new(InjectedTask)

    flow = Hay::Task::Flow::Node::List.new([flow_template])

    task.flow = flow

    mock_catalog = Hay::Consumer::Catalog.new(nil)

    mock_dispatcher = mock

    resulter = Hay::Task::Resulter.new(task.flow, mock_catalog, mock_dispatcher)

    out = nil

    mock_dispatcher.expects(:push).with do |t|
      assert_kind_of Hay::Task, t
      true
    end

    task.call(resulter)
  end

  test 'deflated' do
    template = Hay::Task::Template.new(MockTask)

    instance = template.render

    task = Hay::Task.new(instance)

    thing = {
      'name' => 'injected_task',
      'params' => {}
    }

    flow_template = Hay::Task::Template.new(InjectedTask)

    flow = Hay::Task::Flow::Node::List.new([thing])

    task.flow = flow

    mock_catalog = Hay::Consumer::Catalog.new(nil)
    mock_catalog.add('injected_task', flow_template)

    mock_dispatcher = mock

    resulter = Hay::Task::Resulter.new(task.flow, mock_catalog, mock_dispatcher)

    out = nil

    mock_dispatcher.expects(:push).with do |t|
      assert_kind_of Hay::Task, t
      true
    end

    task.call(resulter)
  end

end


