class CatRentalRequestsController < ApplicationController
  def index
    @cat_rental_requests = CatRentalRequest.all

    render :index
  end

  def create
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new(params[:cat_rental_request])
    # render :json => params
    if @cat_rental_request.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])

    render :show
  end

  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def edit
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :edit
  end

  def update
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if @cat_rental_request.update_attributes(params[:cat_rental_request])
      redirect_to cat_rental_request_url(@cat_rental_request.id)
    else
      render :edit
    end
  end

  def destroy
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if @cat_rental_request
      @cat_rental_request.destroy
    else
      render :json => "could not find cat to destroy"
    end
  end
end
