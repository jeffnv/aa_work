class FriendshipsController < ApplicationController
  def new
    @users = User.where("id != ?", current_user.id)

    render :new
  end

  def create
    current_user.friend_ids = params[:friend_ids]
    current_user.save
    redirect_to friend_circles_url
  end
end
