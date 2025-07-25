require 'test_helper'
require 'active_resource/http_mock'

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  setup do
    ActiveResource::HttpMock.reset!
    @user = {id: 1, name: 'User'}
  end

  test 'destroy only removes album belonging to current user' do
    album = {id: 1, user_id: 1, title: 'mine'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/users/1', {}, @user.to_json, 200
      mock.get '/albums/1', {}, album.to_json, 200
      mock.delete '/albums/1', {}, nil, 200
    end

    delete user_album_url(user_id: 1, id: 1)
    assert_redirected_to user_albums_url(1)
    delete_requests = ActiveResource::HttpMock.requests.select { |r| r.method == :delete }
    assert_equal 1, delete_requests.size

    ActiveResource::HttpMock.reset!
    other_album = {id: 2, user_id: 2, title: 'other'}
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/users/1', {}, @user.to_json, 200
      mock.get '/albums/2', {}, other_album.to_json, 200
    end

    delete user_album_url(user_id: 1, id: 2)
    delete_requests = ActiveResource::HttpMock.requests.select { |r| r.method == :delete }
    assert_equal 0, delete_requests.size, 'should not delete album not belonging to user'
    assert_response :not_found
  end
end
