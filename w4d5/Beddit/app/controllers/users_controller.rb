class UsersController < ApplicationController

  before_action :is_logged_in?, only: [:new, :create]
  before_action :is_current_user?, only: [:edit, :update]

  def show
    render :show
  end

  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # flash
      log_in!(@user)
      redirect_to user_url(@user)

    else
      # flash
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # success!
      redirect_to user_url(@user)
    else
      # failed
      render :edit
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end

  def is_current_user?
    user = User.find(params[:id])
    redirect_to users_url unless current_user && current_user.id == user.id
  end

  def is_logged_in?
    redirect_to users_url if logged_in?
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
