require 'pathname'
require 'rubygems/package'
require 'rubygems/installer'

module Edger
  module Rake
    class Tasks

      include ::Rake::DSL

      def initialize
        yield self
        task :build do
          path = Pathname.glob("*.gemspec")
          spec = Gem::Specification.load(path.first.to_s)
          package = Gem::Package.build(spec)
          Gem::Installer.new(package).install
        end

        task :clean do
          path = Pathname.glob("*.gemspec")
          spec = Gem::Specification.load(path.first.to_s)
          if File.exists?(spec.file_name)
            File.unlink(spec.file_name)
          end
        end

        task :install => :build do
          path = Pathname.glob("*.gemspec")
          spec = Gem::Specification.load(path.first.to_s)
          Gem::Installer.new(spec.file_name).install
        end
      end
    end
  end
end
