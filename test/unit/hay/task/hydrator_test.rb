require File.expand_path('../../../test_helper', __FILE__)

require 'hay/task/hydrator'

class Hay::Task::HydratorTest < Test::Unit::TestCase
  test '.hydrate' do

    mock_task_name = 'mock_task'
    
    mock_hash = mock
    mock_hash.expects(:[]).with('name').returns(mock_task_name)

    mock_task_class = mock
    Hay::Task::Processors.expects(:for_name).with(mock_task_name).returns(mock_task_class)

    mock_hash_task = mock
    mock_hash.expects(:[]).with('task').returns(mock_hash_task)

    mock_hash_flow = mock
    mock_hash.expects(:[]).with('flow').returns(mock_hash_flow)

    mock_flow = mock
    Hay::Task::Flow.expects(:new).with(mock_hash_flow).returns(mock_flow)

    mock_task = mock
    mock_task_class.expects(:new).with(mock_hash_task).returns(mock_task)

    mock_hay_task = mock
    mock_task.expects(:to_hay).returns(mock_hay_task)

    mock_hay_task.expects(:flow=).with(mock_flow)

    hydrator = Hay::Task::Hydrator.new(mock_hash)
    
    result = hydrator.hydrate
    assert_equal mock_hay_task, result
  end
end
