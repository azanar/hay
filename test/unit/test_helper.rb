require 'coveralls'
Coveralls.wear!

if ENV["ENABLE_SIMPLE_COV"]
  require 'simplecov'
  require File.expand_path('../../simplecov_helper', __FILE__)
  SimpleCov.start 'hay'
end

require 'test/unit'

ENV["REDSHIFT_ENV"] = "test"

require 'mocha/setup'

module TestHelper
end
