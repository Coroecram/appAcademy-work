class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :same_user?

  def sign_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to user_url(user)
  end

  def current_user
    return nil unless session[:session_token]
    @current_found_user ||= User.find_by(session_token: session[:session_token])
  end

  def same_user?
    current_user == User.find(params[:id])
  end

  def logged_in?
    !!current_user
  end

  def already_logged_in
    redirect_to users_url if logged_in?
  end

end
