class CatsController < ApplicationController
  def index
    @cats = Cat.all

    render :index
  end

  def create
    @cat = Cat.new(params[:cat])
    if @cat.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def show
    @cat = Cat.find(params[:id])
    @requests = @cat.rental_requests.order("start_date")
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(params[:cat])
      redirect_to cat_url(@cat.id)
    else
      render :edit
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    if @cat
      @cat.destroy
    else
      render :json => "could not find cat to destroy"
    end
  end
end
