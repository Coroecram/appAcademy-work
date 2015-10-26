class SessionsController < ApplicationController

  layout 'login'
  before_action :already_logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
                  params[:user][:email],
                  params[:user][:password]
                  )
    if @user
      sign_in!(@user)
    else
      flash.now[:error] = "Invalid Email or Password"
      @user = User.new(email: params[:user][:email])
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    redirect_to :root
  end

end
