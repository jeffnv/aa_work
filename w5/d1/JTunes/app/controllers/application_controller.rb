class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  def ensure_logged_in
    unless !!current_user
      redirect_to new_session_url
    end
  end
end
