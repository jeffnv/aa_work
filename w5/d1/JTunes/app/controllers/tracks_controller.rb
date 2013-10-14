class TracksController < ApplicationController
  before_filter :ensure_logged_in
  def index
  end

  def new
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(params[:id])
      redirect_to album_url(@track.album_id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def create
    @track = Track.new(params[:track])
    if @track.save
      redirect_to album_url(@track.album_id)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to bands_url
    end
  end

  def delete
  end

  def destroy
    album = Track.find(params[:id]).album_id
    Track.delete(params[:id])
    redirect_to album_url(album)
  end
  
  def show
    @track = Track.find(params[:id])
  end
end
