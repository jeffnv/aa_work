class GistsController < ApplicationController
  def index
    @user = current_user.gists.includes(:favorites,:gist_files, :tags);
    render :json => @user, :include => [:favorites,:gist_files, :tags]
  end

  def create
    @gist = current_user.gists.new(params[:gist]);
    if @gist.save
      render :json => @gist, :include => [:favorites ,:gist_files, :tags]
    else
      render :json => @gist.errors.full_messages, :status => 422
    end
  end
end
