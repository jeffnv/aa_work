class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user])
    if !!@user
      log_in @user
      redirect_to friend_circles_url
    else
      @user = User.new
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end
end
