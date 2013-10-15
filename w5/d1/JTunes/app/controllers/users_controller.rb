class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      log_in_user(@user)
      @user.create_activation_token!
      UserMailer.welcome_email(@user).deliver
      redirect_to bands_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def activate
    user = User.find_by_activation_token(params[:activation_token])
    user.activate!
    flash[:errors] = ["Thanks for activating"]
    redirect_to new_session_url
  end
end
