class Api::PhotosController < ApplicationController
  respond_to :json
  respond_to :html, :only => [:index]

  def index
    @photos = User.find(params[:user_id]).photos
    respond_to do |format|
      format.html { render :index } # entry-point for Backbone app
      format.json { render :json => @photos }
    end
  end


  def create
    @photo = Photo.new(params[:photo])
    @photo.owner_id = current_user.id
    if @photo.save
      render json: @photo
    else
      render json: @photo.errors, status: 422
    end
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      render json: @photo
    else
      render json: @photo.errors, status: 422
    end
  end

end
