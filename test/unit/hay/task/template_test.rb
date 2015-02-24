require File.expand_path('../../../test_helper', __FILE__)

class Hay::Task::TemplateTest < Test::Unit::TestCase
  test '.new raises on unknown task class' do
    mock_task = mock
    mock_task.expects(:class).returns("mock_task")

    Hay::Task::Templates.expects(:for).with(mock_task).returns(nil)
    
    assert_raise(Hay::Task::Exception::UnknownTemplateError){
      Hay::Task::Template.new(mock_task)
    }
  end

  test '.new returns when valid' do
    mock_task = mock

    mock_task_template = mock

    Hay::Task::Templates.expects(:for).with(mock_task).returns(mock_task_template)

    mock_template_instance = mock

    mock_task_template.expects(:new).with(mock_task).returns(mock_template_instance)

    result = Hay::Task::Template.new(mock_task)

    assert_equal mock_template_instance, result
  end
end
