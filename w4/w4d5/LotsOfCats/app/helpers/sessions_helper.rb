module SessionsHelper
  def current_user=(user)
    new_token = User.generate_session_token
    session[:session_token] = new_token
    @user.sessions << Session.new(session_token: new_token, env: request.env['HTTP_USER_AGENT'])
    # @current_user = user
    # session[:session_token] = user.session_token
  end

  def current_user
    @current_user ||= Session.find_user_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end
end
