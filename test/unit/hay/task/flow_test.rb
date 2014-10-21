require File.expand_path('../../../test_helper', __FILE__)

require 'hay/task/flow'

class Hay::Task::FlowTest < Test::Unit::TestCase
  test '.dehydrate tasks' do

    mock_task = mock
    mock_task.expects(:kind_of?).with(Hash).returns(false)

    mock_dehydrated_task = mock
    mock_task.expects(:dehydrate).returns(mock_dehydrated_task)

    flow = Hay::Task::Flow.new([mock_task])
    result = flow.dehydrate

    assert_equal 1, result.length
    assert_equal mock_dehydrated_task, result.first
  end

  test '.dehydrate hashes' do

    mock_task = mock
    mock_task.expects(:kind_of?).with(Hash).returns(true)

    flow = Hay::Task::Flow.new([mock_task])
    result = flow.dehydrate

    assert_equal 1, result.length
    assert_equal mock_task, result.first
  end
  test '.inflate' do

    mock_task = mock

    mock_template = mock
    Hay::Task::Template.expects(:new).with(mock_task).returns(mock_template)

    flow = Hay::Task::Flow.new([mock_task])
    result = flow.inflate

    assert_equal 1, result.length
    assert_equal mock_template, result.first
  end
end
