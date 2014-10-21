require File.expand_path('../../../test_helper', __FILE__)

require 'hay/task/hydrators'

class Hay::Task::HydratorsTest < Test::Unit::TestCase
  test '.for' do
    mock_task = mock

    mock_task_name = "mock_task"
    mock_task.expects(:task_name).twice.returns(mock_task_name)

    mock_hydrator_class = mock

    Hay::Task::Hydrators.register(mock_task, mock_hydrator_class)

    params = {'name' => mock_task_name}

    mock_hydrator = mock
    mock_hydrator_class.expects(:new).with(params).returns(mock_hydrator)

    hydrator = Hay::Task::Hydrators.for(params)

    assert_equal mock_hydrator, hydrator

  end
end
