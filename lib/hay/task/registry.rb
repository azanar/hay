#require 'hay/task/factory'

module Hay
  module Task
    ##
    # A registry for any tasks which the system knows how to create.
    #
    module Registry
      def self.register(task)
        Hay.logger.info "Registering #{task} for #{task.task_name}"

        #Hay::Task::Factory::Registry.register(task)
      end
    end
  end
end
