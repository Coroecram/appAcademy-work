module ApplicationHelper
  def auth_token
    <<-HTML.html_safe
      <input type="hidden"
      name="authenticity_token"
      value="#{form_authenticity_token}">
    HTML
  end

  def log_in_or_out
    if logged_in?
      <<-HTML.html_safe
      <form action="/session" method="POST">
        <input type="hidden" name="_method" value="DELETE">
        #{auth_token}
        <button>Log Out</button>
      </form>
      HTML
    else
      <<-HTML.html_safe
      <a href="#{new_session_url}">Log In</a>
      HTML
    end
  end

end
