require 'hay/task/hydrators'
require 'hay/task/resolvers'

module Hay
  module Task
    module Resolver
      class Hash
        def initialize(hash)
          @hash = hash
        end

        def build
          Hay::Task::Hydrators.for(@hash).hydrate
        end
        Hay::Task::Resolvers.register(::Hash, self)
      end
    end
  end
end
