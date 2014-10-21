require File.expand_path('../../../test_helper', __FILE__)

require 'hay/task/resulter'

class Hay::Task::ResulterTest < Test::Unit::TestCase
  test 'submit' do
    mock_flow = mock
    mock_router = mock

    mock_hydrator = mock

    mock_tasks = 5.times.map { mock }

    mock_data = mock
    mock_hydrator.expects(:hydrate_with).with(mock_data).returns(mock_tasks)

    Hay::Task::Template::Hydrator.expects(:new).returns(mock_hydrator)

    mock_tasks.each {|t|
      mock_router.expects(:push).with(t)
    }

    resulter = Hay::Task::Resulter.new(mock_flow, mock_router)

    resulter.submit(mock_data)
  end
end
