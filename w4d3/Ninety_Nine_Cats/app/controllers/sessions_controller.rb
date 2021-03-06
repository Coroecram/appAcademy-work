class SessionsController < ApplicationController

  before_action :cat_direct, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
                 params[:user][:username],
                 params[:user][:password]
                 )

    if @user
      log_in!(@user)
    else
      @user = User.new(username: params[:user][:username])
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end

    redirect_to cats_url
  end
end
