module Hay
  class Task
    module Flow
      module Node
        class List
          include Enumerable

          def initialize(list = [])
            nodes = list || []

            unless nodes.kind_of?(Array)
              raise "This has to be an array, dude!"
            end

            @nodes = nodes.map do |t|
              case t
              when Hydrated
                t
              when Dehydrated
                t
              when Hay::Task::Template
                Hydrated.new(t)
              when Hash
                Dehydrated.new(t)
              else
                puts "Got unexpected node #{t.inspect}"
                raise
              end
            end
          end

          def inflate(catalog)
            self.class.new(@nodes.map {|t| t.inflate(catalog)})
          end

          def deflate
            self.class.new(@nodes.map {|t| t.dehydrate })
          end

          def dehydrate
            deflate
          end

          def each
            @nodes.each do |t|
              yield t
            end
          end
        end
      end
    end
  end
end

