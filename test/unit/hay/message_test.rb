
require File.expand_path('../../test_helper', __FILE__)

require 'hay/message'

class Hay::MessageTest < Test::Unit::TestCase
  setup do
    @mock_task = mock

    @message = Hay::Message.new(@mock_task)
  end

  test "#payload" do
    mock_payload = mock
    @mock_task.expects(:dehydrate).returns(mock_payload)

    result = @message.payload

    assert_equal mock_payload, result
  end

  test "#destination" do
    mock_route = mock

    mock_name = mock
    @mock_task.expects(:task_name).returns(mock_name)

    Hay::Routes.expects(:for_name).with(mock_name).returns(mock_route)

    result = @message.destination

    assert_equal mock_route, result
  end

  test "#initialize fails when passed a task hash" do
    mock_task = {}

    assert_raise(RuntimeError) do
      message = Hay::Message.new(mock_task)
    end

  end
end
