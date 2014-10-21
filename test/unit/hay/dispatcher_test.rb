require File.expand_path('../../test_helper', __FILE__)

require 'hay/dispatcher'

class Hay::DispatcherTest < Test::Unit::TestCase
  setup do
    @mock_agent = mock
    @mock_consumer = mock
    @mock_task = mock
    @mock_task_name = mock

    @mock_router = mock
    Hay::Router.expects(:new).with(@mock_agent).returns(@mock_router)

    @dispatcher = Hay::Dispatcher.new(@mock_consumer, @mock_agent)
  end

  test '#push ours' do
    @mock_consumer.expects(:ours?).with(@mock_task).returns(true)

    @mock_router.expects(:push).never
    @mock_consumer.expects(:push).with(@mock_task)

    @dispatcher.push(@mock_task)
  end

  test '#push not ours' do
    @mock_consumer.expects(:ours?).with(@mock_task).returns(false)

    mock_message = mock 
    Hay::Message.expects(:new).with(@mock_task).returns(mock_message)

    @mock_router.expects(:push).with(mock_message)
    @mock_consumer.expects(:push).never

    @dispatcher.push(@mock_task)
  end
end
