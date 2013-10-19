class SessionsController < ApplicationController
  def new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user])
  
    if @user 
      login_user!(@user)
      
      redirect_to goals_url
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end
  
  def destroy
    logout_user!
    redirect_to new_session_url
  end
end
