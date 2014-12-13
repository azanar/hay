require File.expand_path('../../test_helper', __FILE__)

require 'hay/consumer'

class Hay::Resolver::IntegrationTest < Test::Unit::TestCase
  setup do
    @resolver = Hay::Resolver.new
  end

  test 'foo' do
    mock_task_template = mock
    mock_task = mock

    @resolver.catalog.add('mock_task', mock_task_template)
    task = @resolver.resolve(mock_task)

    puts task.inspect
  end

end
