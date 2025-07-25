require 'test_helper'

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "redirect when album not found" do
    user = User.new(id: 1)
    User.stub :find, user do
      stub_albums = Minitest::Mock.new
      stub_albums.expect :find, -> { raise ActiveResource::ResourceNotFound.new(nil) }, ['99']
      user.stub :albums, stub_albums do
        delete user_album_url(user, id: '99')
        assert_redirected_to user_albums_path(user)
        assert_equal 'Album not found.', flash[:notice]
      end
      stub_albums.verify
    end
  end
end
