require File.expand_path('../../test_helper', __FILE__)

require 'hay/route'

class Hay::Route::AutowiredTest < Test::Unit::TestCase
  test "autowiring" do
    dummy_route_klass = Class.new

    Hay::Routes.expects(:register).with(dummy_route_klass)

    dummy_route_klass.class_exec do
      include Hay::Route::Autowired

      def tasks=(tasks)
        @tasks = tasks
      end

      def tasks
        @tasks
      end
    end

    assert dummy_route_klass.include?(Hay::Route)
  end
end
class Hay::RouteTest < Test::Unit::TestCase
  setup do
    dummy_route_klass = Class.new

    dummy_route_klass.class_exec do
      include Hay::Route

      def tasks=(tasks)
        @tasks = tasks
      end

      def tasks
        @tasks
      end
    end

    mock_agent = mock

    @dummy_route = dummy_route_klass.new(mock_agent)
  end

  test '#ours? if task is ours' do

    mock_message = mock

    mock_task = mock
    mock_message.expects(:task).returns(mock_task)

    mock_task_class = mock
    mock_task.expects(:class).returns(mock_task_class)

    @dummy_route.tasks = [mock_task_class]

    assert @dummy_route.ours?(mock_message)
  end

  test '#ours? if task is not ours' do
    mock_message = mock

    mock_task = mock
    mock_message.expects(:task).returns(mock_task)
    
    mock_task_class = mock
    mock_task.expects(:class).returns(mock_task_class)
    
    @dummy_route.tasks = []

    assert !@dummy_route.ours?(mock_message)
  end
end
