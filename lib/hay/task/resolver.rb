require 'hay'

require 'hay/task/exception/unknown_template_error'

module Hay
  module Task
    # A Resolver is responsible for figuring out how to transform an arbitrary
    # input parameter into something digestable by Hay.
    module Resolver
      def self.new(params)
        resolver_class = Hay::Task::Resolvers.punch(params)
        if resolver_class.nil?
          raise Hay::Task::Exception::UnknownTemplateError.new("No resolver for #{params.class}")
        end
        resolver_class.new(params).build
      end
    end
  end
end
