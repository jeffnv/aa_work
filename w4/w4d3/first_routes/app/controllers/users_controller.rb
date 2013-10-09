class UsersController < ApplicationController
  def index
    render :json => User.all
  end

  def create
    user = User.new(params[:user])
    if user.save
      render :json => user
    else
      render :json => user.errors, :status => :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(params[:user])
      render :json => user
    else
      render :json => user.errors, :status => :unprocessable_entity
    end
  end

  def show
    user = User.find_by_id(params[:id])
    if user
      render :json => user
    else
      render :text => "user not found"
    end
  end

  def destroy
    user = User.find_by_id(params[:id])
    if user
      render :json => user.destroy
    else
      render :text => "user not found"
    end
  end
end
