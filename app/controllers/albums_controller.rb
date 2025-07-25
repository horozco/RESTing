class AlbumsController < ApplicationController
  before_action :set_user, only: [:index, :destroy]
  before_action :set_album, only: [:destroy]

  def index
    # json-server does not support nested album routes so filter by user_id
    @albums = Album.for_user(@user.id)
  end

  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to user_albums_path(@user), notice: 'Album was successfully destroyed.' }
    end
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end