require File.expand_path('../../../../test_helper', __FILE__)

require 'hay/tasks'
require 'hay/task/template/hash'

class Hay::Task::Template::TaskTest < Test::Unit::TestCase
  test '#render' do
    mock_template_task = mock
    mock_task = mock

    mock_template_task.expects(:task_name).returns("mock_task")
    mock_template_task.expects(:payload).returns("foo" => "fooval")


    mock_template_task_flow = mock
    mock_template_task.expects(:flow).returns(mock_template_task_flow)

    mock_task_factory = mock
    mock_task_factory.expects(:new).with({"foo" => "fooval", "bar" => "barval"}).returns(mock_task)

    mock_hay_task = mock
    mock_task.expects(:to_hay).returns(mock_hay_task)

    mock_hay_task.expects(:flow=).with(mock_template_task_flow)

    Hay::Tasks.expects(:for).with("mock_task").returns(mock_task_factory)

    template = Hay::Task::Template::Task.new(mock_template_task)
    result = template.render({"bar" => "barval"})

    assert_equal mock_hay_task, result
  end
end
