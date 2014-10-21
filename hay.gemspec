lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hay/version'

Gem::Specification.new do |spec|
  spec.name        = "hay"
  spec.version     = Hay::VERSION
  spec.summary     = "A workflow definition framework."
  spec.platform    = "ruby"

  spec.homepage    = "https://github.com/azanar/hay"
  spec.license     = "MIT"

  spec.authors     = ["Ed Carrel"]
  spec.email       = ["edward@carrel.org"]

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'punchout', '~> 0'

  spec.add_development_dependency 'test-unit', '~> 3'
  spec.add_development_dependency 'mocha', '~> 1'
  spec.add_development_dependency 'simplecov', '~> 0'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
