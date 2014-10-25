require File.expand_path('../../test_helper', __FILE__)

require 'hay/task'

class Hay::TaskTest < Test::Unit::TestCase
  test "autowiring" do
    dummy_task_klass = Class.new

    Hay::Tasks.expects(:register).with(dummy_task_klass)

    dummy_task_klass.class_exec do
      def self.task_name
        "dummy_task"
      end

      include Hay::Task::Autowired
    end

    assert dummy_task_klass.include?(Hay::Task)
  end
end
