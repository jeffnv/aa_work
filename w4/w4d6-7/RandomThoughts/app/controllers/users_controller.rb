class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    # render json: params[:user]
    @user = User.new(params[:user])
    if @user.save
      redirect_to moments_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
  end

  def show
  end
end
