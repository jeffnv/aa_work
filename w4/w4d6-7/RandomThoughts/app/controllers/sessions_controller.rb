class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user])
    if !!@user
      self.current_user = @user
      # raise "hell"
      redirect_to moments_url
    else
      flash.now[:errors] = ["User/password not found"]
      render :new
    end
  end

  def destroy
  end
end
