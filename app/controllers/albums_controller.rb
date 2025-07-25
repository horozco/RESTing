class AlbumsController < ApplicationController
  before_action :set_user, only: [:index, :destroy]
  before_action :set_album, only: [:destroy]

  def index
    @albums = @user.albums
  end

  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to user_albums_path(@user), notice: 'Album was successfully destroyed.' }
    end
  end

  private

  def set_album
    @album = @user.albums.find(params[:id])
  rescue ActiveResource::ResourceNotFound
    redirect_to user_albums_path(@user), notice: 'Album not found.'
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end