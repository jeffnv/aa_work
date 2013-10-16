class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  def ensure_logged_in
    redirect_to new_session_url unless !!current_user
  end
end
