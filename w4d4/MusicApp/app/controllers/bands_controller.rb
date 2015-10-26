class BandsController < ApplicationController

  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save!
      redirect_to bands_url
    else
      flash[:error]= @band.errors.full_messages.to_sentence
      render:new, status: :unprocessable_entity
    end
  end



  private

  def band_params
    params.require(:band).permit(:title)
  end
end
