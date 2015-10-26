class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user,
                :log_in!,
                :require_log_in,
                :logged_in?,
                :auth_token

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def auth_token
    <<-HTML.html_safe
    <input
        type="hidden"
        name="authenticity_token"
        value="#{ form_authenticity_token }">
    HTML
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def require_log_in
    redirect_to users_url unless logged_in?
  end

end
