class AlbumsController < ApplicationController

  def albums
  end

  def create
    @album = Album.new(params[:album])
    if @album.save
      redirect_to band_url(@album.band_id)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to bands_url
    end
  end

  def show
    @album = Album.find(params[:id])
    @tracks = @album.tracks
    @track = Track.new
  end
end
