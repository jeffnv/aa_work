class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    if !!current_user #if there is a user currently logged in
      @cat = Cat.new(params[:cat].merge( user_id: current_user.id))
      if @cat.save
        redirect_to cats_url
      else
        render :new
      end
    else
      flash[:errors] = ["Must be logged in to register a cat!"]
      redirect_to new_session_url
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if current_user.id == @cat.user_id
      if @cat.update_attributes(params[:cat])
        redirect_to cats_url
      else
        render :edit
      end
    else
      flash[:errors] = ["NOT YOUR CAT"]
      redirect_to cats_url
    end
  end
end
