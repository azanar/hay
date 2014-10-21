require File.expand_path('../../../../test_helper', __FILE__)

require 'hay/task/template/hash'
require 'hay/task/hydrators'

class Hay::Task::Template::HashTest < Test::Unit::TestCase
  test '#render' do
    mock_params = mock
    mergable_params = {"bar" => "barval"}

    mock_name = "mock_task"

    mock_params.expects(:fetch).with("name").returns(mock_name)

    mock_merged_task = mock

    mock_task_hydrator = mock
    mock_task_hydrator.expects(:hydrate).returns(mock_merged_task)

    mock_merged_params = mock
    mock_params.expects(:merge).with(mergable_params).returns(mock_merged_params)

    Hay::Task::Hydrators.expects(:for).with(mock_merged_params).returns(mock_task_hydrator)

    template = Hay::Task::Template::Hash.new(mock_params)

    result = template.render(mergable_params)
    assert_equal mock_merged_task, result
  end
end
