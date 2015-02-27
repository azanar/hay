require File.expand_path('../../test_helper', __FILE__)

require 'hay/consumer'

class Hay::Resolver::IntegrationTest < Test::Unit::TestCase
  class Hay::Resolver::Hydrator
    def hydrator_map
      {
        ::Hash => 
          Hay::Resolver::Hydrator::Hash,
        Hay::Task => Hay::Resolver::Hydrator::Template,
        Hay::Task::Template => Hay::Resolver::Hydrator::Template,
        Mocha::Mock => Hay::Resolver::Hydrator::Template
      }
    end
  end

  class Hay::Resolver::Cutter
    def cutter_map
      {
        Hay::Task => Hay::Resolver::Cutter::Task,
        Hay::Task::Template => Hay::Resolver::Cutter::Template,
        Mocha::Mock => Hay::Resolver::Cutter::Template
      }
    end
  end

  setup do
    @resolver = Hay::Resolver.new
  end

  test 'taskish that needs hydration and cutting' do
    mock_task_template = mock
    mock_task = {}

    @resolver.catalog.add('mock_task', mock_task_template)

    mock_task.expects(:[]).with('name').returns('mock_task')
    mock_task.expects(:[]).with('task').returns({})
    mock_task.expects(:[]).with('flow').returns({})

    mock_merged_task = mock

    mock_task_template.expects(:merge).returns(mock_merged_task)
    mock_merged_task.expects(:flow=)

    mock_rendered_task = mock
    mock_merged_task.expects(:render).returns(mock_rendered_task)

    task = @resolver.resolve(mock_task)

    assert_equal task, mock_rendered_task
  end

  test 'taskish that needs cutting but no hydration' do
    mock_task_instance = mock
    mock_task_instance.expects(:include?).returns(Hay::Task::Instance)

    mock_new_task_instance = mock
    mock_task_instance.expects(:new).returns(mock_new_task_instance)

    mock_task_template = Hay::Task::Template.new(mock_task_instance, {})

    @resolver.catalog.add('mock_task', mock_task_template)

    task = @resolver.resolve(mock_task_template)

    assert_equal task.instance, mock_new_task_instance
  end

  test 'taskish that needs neither cutting nor hydration' do
    mock_task_instance = mock
    mock_task_instance.expects(:include?).returns(Hay::Task::Instance)
    
    mock_template = mock

    mock_task = Hay::Task.new(mock_template, mock_task_instance)
    mock_task_template = Hay::Task::Template.new(mock_task_instance, {})

    @resolver.catalog.add('mock_task', mock_task_template)

    task = @resolver.resolve(mock_task)

    assert_equal task.instance, mock_task_instance
  end

end
