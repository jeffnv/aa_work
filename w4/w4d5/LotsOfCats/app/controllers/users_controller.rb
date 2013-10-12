class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  def new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash.now[:notice] = "Success!"
      self.current_user = @user
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      flash.now[:errors] << "You are an idiot."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end
end
