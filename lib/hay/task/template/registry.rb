module Hay
  module Task
    module Template
      module Registry
        @@template_maps = {}

        def self.register(task_class, template)
          Hay.logger.info "Registering template #{template} for #{task_class}"
          @@template_maps[task_class] = template
        end

        def self.template_for(task_class)
          @@template_maps[task_class]
        end
      end
    end
  end
end
