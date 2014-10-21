require File.expand_path('../../test_helper', __FILE__)

require 'hay/routes'

class Hay::RoutesTest < Test::Unit::TestCase
  setup do
    @mock_route = mock

    @mock_task_name = "mock.task"

    mock_task_class = mock
    mock_task_class.expects(:task_name).returns(@mock_task_name)

    @mock_route.expects(:tasks).returns([mock_task_class])

    Hay::Routes.register(@mock_route)

    @mock_task = mock
  end

  test ".for_task found" do

    @mock_task.expects(:task_name).returns(@mock_task_name)

    router = Hay::Routes.for_task(@mock_task)
    assert_equal @mock_route, router
  end

  test ".for_task not found" do
    mock_task = mock
    mock_task.expects(:task_name).returns("mock.othertask")

    router = Hay::Routes.for_task(mock_task)
    assert_equal nil, router
  end
end

