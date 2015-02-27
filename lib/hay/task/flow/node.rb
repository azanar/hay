module Hay
  class Task
    module Flow
      module Node
        def initialize(template)
          unless template.kind_of?(Hay::Task::Template) or template.kind_of?(Hash)
            puts "Got a template of type #{template.class}"
            raise
          end
          @template = template
        end
      end
    end
  end
end
