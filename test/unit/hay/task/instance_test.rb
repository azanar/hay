require File.expand_path('../../../test_helper', __FILE__)

require 'hay/task/instance'

class Hay::Task::InstanceTest < Test::Unit::TestCase
  test "autowiring" do
    dummy_task_klass = Class.new

    #Hay::Tasks.expects(:register).with(dummy_task_klass)

    dummy_task_klass.class_exec do
      def self.task_name
        "dummy_task"
      end

      include Hay::Task::Instance
    end

    assert dummy_task_klass.include?(Hay::Task::Instance)
  end
end
