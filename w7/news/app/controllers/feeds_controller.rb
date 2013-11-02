class FeedsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => Feed.all }
    end
  end
  
  def show
    @feed = Feed.find(params[:id])
    if(@feed.entries.last.updated_at < 10.seconds.ago)
      @feed.reload
    end
    render :json => @feed
  end

  def create
    feed = Feed.find_or_create_by_url(params[:feed][:url])
    if feed
      render :json => feed
    else
      render :json => { error: "invalid url" }, status: :unprocessable_entity
    end
  end
end
