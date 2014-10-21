require File.expand_path('../../test_helper', __FILE__)

require 'hay/router'

class Hay::RouterTest < Test::Unit::TestCase
  setup do
    @mock_agent = mock

    @router = Hay::Router.new(@mock_agent)
  end

  test '#push' do
    mock_route_klass = mock

    mock_message = mock
    mock_message.expects(:destination).returns(mock_route_klass)

    mock_route = mock
    mock_route_klass.expects(:new).with(@mock_agent).returns(mock_route)

    mock_route.expects(:push).with(mock_message)
    
    @router.push(mock_message)
  end

end
