require File.expand_path('../../../test_helper', __FILE__)

require 'hay/task/decorator'

class Hay::Task::DecoratorTest < Test::Unit::TestCase
  setup do
    @mock_task = mock


    @mock_flow = mock

    @decorated_task = Hay::Task::Decorator.new(@mock_task)
  end

  def flows 
    Hay::Task::Flow.expects(:new).returns(@mock_flow)
  end

  test "#flow" do
    flows
    result = @decorated_task.flow

    assert_equal @mock_flow, result
  end

  test "#dehydrate" do
    flows

    mock_dehydrated_task = mock

    @mock_task.expects(:task_name).returns("mock_task")
    @mock_task.expects(:dehydrate).returns(mock_dehydrated_task)

    mock_dehydrated_flow = mock
    @mock_flow.expects(:dehydrate).returns(mock_dehydrated_flow)

    expected = {"name" => "mock_task",
                "task" => mock_dehydrated_task,
                "flow" => mock_dehydrated_flow}
    result = @decorated_task.dehydrate

    assert_equal expected, result
  end

  test "#process" do
    flows
    
    mock_dispatcher = mock

    mock_resulter = mock
    Hay::Task::Resulter.expects(:new).with(@mock_flow, mock_dispatcher).returns(mock_resulter)

    @mock_task.expects(:process).with(mock_resulter)

    @decorated_task.process(mock_dispatcher)
  end

  test "#other_method" do
    mock_result = mock

    @mock_task.expects(:delegated_method).returns(mock_result)

    result = @decorated_task.delegated_method

    assert_equal mock_result, result
  end
end

