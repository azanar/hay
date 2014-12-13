require File.expand_path('../../test_helper', __FILE__)

require 'hay/consumer'

class Hay::Consumer::IntegrationTest < Test::Unit::TestCase
  setup do
    @mock_agent = mock

    @consumer = Hay::Consumer.new(@mock_agent)
  end
end
