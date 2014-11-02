require File.expand_path('../../test_helper', __FILE__)

require 'hay/task'
require 'hay/task/instance'
require 'hay/task/resulter'

class Hay::Task::IntegrationTest < Test::Unit::TestCase
  class MockTask
    include Hay::Task::Instance

    def call(resulter)
      resulter.submit('foo')
    end
  end

  test 'task' do
    template = Hay::Task::Template.new('whatever_task', MockTask)

    instance = template.render

    task = Hay::Task.new(instance)

    mock_dispatcher = mock

    resulter = Hay::Task::Resulter.new(task.flow, mock_dispatcher)

    task.call(resulter) 
    
    puts task.inspect
  end

end


