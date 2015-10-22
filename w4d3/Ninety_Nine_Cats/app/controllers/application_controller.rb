class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    return nil unless session[:session_token]
    @current_found_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to cats_url
  end

  def cat_direct
    redirect_to cats_url if current_user
  end

  def owner_check
    current_user.cats.each do |cat|
      return if cat.id == params[:id].to_i
    end
    flash[:message] = "Not your cat to edit!"
    redirect_to cat_url(params[:id])
  end

end
