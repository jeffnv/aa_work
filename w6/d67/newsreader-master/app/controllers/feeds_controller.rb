class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => @feeds.to_json(include: :entries) }
    end
  end

  def create
    feed = Feed.find_or_create_by_url(params[:feed][:url])
    if feed
      feed.reload
      render :json => feed.to_json(include: :entries)
    else
      render :json => { error: "invalid url" }, status: :unprocessable_entity
    end
  end

end
