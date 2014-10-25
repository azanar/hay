require File.expand_path('../../../../test_helper', __FILE__)

require 'hay/task/template/hydrator'

class Hay::Task::Template::HydratorTest < Test::Unit::TestCase
  test 'hydrate_with' do
    mock_flow = mock

    mock_tasks = 5.times.map do
      mock
    end

    mock_templates = 5.times.map do |x|
      t = mock
      t.expects(:render).returns(mock_tasks[x])
      t
    end

    mock_flow.expects(:inflate).returns(mock_templates)

    h = Hay::Task::Template::Hydrator.new(mock_flow)

    result_tasks = h.hydrate_with({"foo" => "bar"})

    assert_equal mock_tasks, result_tasks
  end
end


