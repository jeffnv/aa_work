class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      log_in @user
      redirect_to friend_circles_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def forgot_password
    render :forgot_password
  end


  def send_reset_mail
    user = User.find_by_email(params[:user][:email])
    reset_token = user.generate_reset_token!

    mail = UserMailer.reset_email(user)
    mail.deliver!

  end

  def reset
    @reset_token = params[:reset_token]
    render :reset
  end

  def reset_password
    @user = User.find_by_reset_token(params[:reset_token])
    if !!@user
      @user.password = params[:user][:password]
      @user.save!
      log_in(@user)
      redirect_to friend_circles_url
    else
      flash[:errors] = ["Unknown User"]
      redirect_to new_session_url
    end
  end
end
