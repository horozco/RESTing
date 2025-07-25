require 'test_helper'
require 'active_resource/http_mock'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    ActiveResource::HttpMock.reset!
  end

  test 'creates a user via remote API' do
    attrs = {name: 'Test', username: 'tester', email: 'test@example.com'}
    response_body = attrs.merge(id: 99).to_json
    ActiveResource::HttpMock.respond_to do |mock|
      mock.post '/users', attrs.to_json, response_body, 201, 'Location' => '/users/99'
    end

    post users_url, params: {user: attrs}
    post_requests = ActiveResource::HttpMock.requests.select { |r| r.method == :post }
    assert_equal 1, post_requests.size, 'expected one POST request to remote API'
    assert_redirected_to user_url(99)
  end
end
