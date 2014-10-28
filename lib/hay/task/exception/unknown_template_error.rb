module Hay
  class Task
    class Exception < StandardError
      class UnknownTemplateError < StandardError
        def initialize(template_name)
          @template_name = template_name
        end

        def message
          "Failed to find template #{@template_name}"
        end
      end
    end
  end
end

