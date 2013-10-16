class FriendCirclesController < ApplicationController
  before_filter :ensure_logged_in
  def index

  end

  def new
    @circle = Circle.new
    render :new
  end

  def create
    @circle = current_user.circles.build(params[:circle])
    if @circle.save
      redirect_to friend_circles_url
    else
      flash.now[:errors] = @circle.errors.full_messages
      render :new
    end
  end
end