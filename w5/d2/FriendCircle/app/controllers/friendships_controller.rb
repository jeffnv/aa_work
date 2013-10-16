class FriendshipsController < ApplicationController
  def new
    @users = User.where("id != ?", current_user.id)
    render :new
  end
end
