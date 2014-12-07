require File.expand_path('../../test_helper', __FILE__)

require 'hay/consumer'

class Hay::Consumer::IntegrationTest < Test::Unit::TestCase
  setup do
    @mock_agent = mock

    @consumer = Hay::Consumer.new(@mock_agent)
  end

  test 'ours?' do
    mock_task = mock

    @consumer.ours?(mock_task)
  end


  test 'thing' do
    mock_task = mock

    @consumer.push(mock_task)
  end
end
