class TracksController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def update
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
  end
  
  def show
    @track = Track.find(params[:id])
  end
end
