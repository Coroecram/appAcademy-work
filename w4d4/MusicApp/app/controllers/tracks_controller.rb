class TracksController < ApplicationController

  def index
    @tracks = Track.all
    render :index
  end

  def create
    @track = Track.new(track_params)

  if @track.save
    redirect_to bands_url
  else
    render :new
  end
end


  private
  def track_params
    params.require(:track).permit(:title)
  end
end
