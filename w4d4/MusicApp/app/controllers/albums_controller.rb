class AlbumsController < ApplicationController
  def index
    @albums = Album.all
    render :index
  end

  def new
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to albums_url
    else
      render :new
    end
  end


    private

    def album_params
      params.require(:album).permit(:title)
    end
end
