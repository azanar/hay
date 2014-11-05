require 'hay'

module Hay
  class Task
    class Template
      class Hydrator
        def initialize(templates)
          @templates = templates
        end

        def hydrate(params = {})
          @templates.map do |template|
            template.render(params).tap {|t| Hay.logger.debug "HYDRATED TEMPLATE: #{t.inspect}" }
          end
        end
      end
    end
  end
end
