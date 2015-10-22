class CatRentalRequestsController < ApplicationController

  def index
    @requests = CatRentalRequest.all
    render json: @requests
  end

  def new
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.new(rental_params)

    if @request.save
      redirect_to cat_url(@request.cat)
    else
      render :new
    end
  end



  private

  def rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
