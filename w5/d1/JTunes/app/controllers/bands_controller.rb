class BandsController < ApplicationController
  before_filter :ensure_logged_in
  
  def new
  end
  
  def create
    @band = Band.new(params[:band])
    
    unless @band.save
      flash[:errors] = @band.errors.full_messages
    end
    
    redirect_to bands_url
  end

  def edit
  end

  def index
    @band = Band.new
    @bands = Band.all
  end
  
  def show
    @bands = Band.all
    @album = Album.new
    @band = Band.find(params[:id])
    
  end
end
