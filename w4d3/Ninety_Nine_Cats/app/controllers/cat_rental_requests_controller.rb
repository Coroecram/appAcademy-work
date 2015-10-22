class CatRentalRequestsController < ApplicationController

  # before_action :overlapping_requests

  def index
    @requests = CatRentalRequest.all
    render json: @requests
  end

  def new
    @request = CatRentalRequest.new
    @request.cat_id = params[:cat_id]
    # fail
    render :new
  end

  def create
    @request = CatRentalRequest.new(rental_params)
    @request.user_id = current_user.id

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
