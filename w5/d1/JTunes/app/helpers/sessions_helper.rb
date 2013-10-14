module SessionsHelper
  def current_user
    User.find_by_session_token(session[:session_token])
  end
  
  def log_in_user(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def log_out_user(user)
    @user
  end
end
