module SessionsHelper

  
  def current_user
    User.find_by_session_token(session[:session_token])
  end
  
  def current_user=(user)
    raise "hell"
    session[:session_token] = user.reset_session_token
  end
end
