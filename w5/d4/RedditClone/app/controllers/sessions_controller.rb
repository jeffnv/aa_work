class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user])
    if @user
      log_in_user @user
      redirect_to links_url
    else
      @user = User.new
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
    end
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
