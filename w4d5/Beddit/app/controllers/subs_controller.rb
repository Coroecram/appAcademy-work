class SubsController < ApplicationController

  before_action :is_sub_moderator?, only: [:edit, :update, :destroy]
  before_action :is_logged_in?, only: [:new, :create]

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @moderator = User.find(params[:user_id])
    @sub = Sub.new(moderator_id: @moderator.id)
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to subs_url
    else

      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    @sub
    redirect_to subs_url
  end

  def is_sub_moderator?
    sub = Sub.find(params[:id])
    redirect_to subs_url unless current_user && current_user.id == sub.moderator_id
  end

  def is_logged_in?
    redirect_to subs_url unless logged_in?
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end
end
