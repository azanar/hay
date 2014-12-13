require 'hay/resolver/catalog'
require 'hay/resolver/cutter'
require 'hay/resolver/hydrator'

module Hay
  class Resolver
    def resolve(taskish)
      hydrator = Hydrator.new(@catalog, taskish)
      template = hydrator.hydrate

      cutter = Cutter.new(template)
      cutter.cut
    end

    def catalog
      @catalog ||= Hay::Resolver::Catalog.new
    end
  end
end
