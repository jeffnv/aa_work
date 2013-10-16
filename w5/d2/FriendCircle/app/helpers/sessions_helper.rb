module SessionsHelper
  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_in(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out
    if !!current_user
      current_user.reset_session_token!
    end
    session[:session_token] = nil
  end
end
