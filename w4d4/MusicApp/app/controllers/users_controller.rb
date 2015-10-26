class UsersController < ApplicationController

  before_action :same_user?, only: :destroy
  before_action :already_logged_in, only: [:new, :create, :destroy]

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
      redirect_to users_url
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render:new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def destroy
    User.delete(current_user)
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
