module SessionsHelper
  def log_in_user(user)
    session[:session_token] = user.reset_session_token!
    @current = user
  end

  def current_user
    @current ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end
end
