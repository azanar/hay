require 'hay'

module Hay
  class Task
    class Template
      class Hydrator
        def initialize(flow)
          @templates = flow.inflate
        end

        def hydrate
          hydrate_with({})
        end

        def hydrate_with(params)
          @templates.map do |template|
            template.render(params).tap {|t| Hay.logger.debug "HYDRATED TEMPLATE: #{t.inspect}" }
          end
        end
      end
    end
  end
end
