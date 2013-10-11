class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(params[:cat_rental_request])
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      render :new
    end
  end

  def approve
    if current_user.id == CatRentalRequest.find(params[:id]).cat.user_id
      @cat_rental_request = CatRentalRequest.find(params[:id])
      @cat_rental_request.approve!
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      flash[:errors] = ["STOP IT NOT YOUR CAT"]
      redirect_to cats_url
    end
  end

  def deny
    if current_user.id == CatRentalRequest.find(params[:id]).cat.user_id
      @cat_rental_request = CatRentalRequest.find(params[:id])
      @cat_rental_request.deny!
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      flash[:errors] = ["STOP IT NOT YOUR CAT"]
      redirect_to cats_url
    end
  end
end
