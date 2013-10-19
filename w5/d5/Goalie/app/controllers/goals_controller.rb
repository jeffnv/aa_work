class GoalsController < ApplicationController
  before_filter :ensure_logged_in
  
  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(params[:goal])
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goals_url
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def index
    @goals = Goal.all
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def edit
  end
end
