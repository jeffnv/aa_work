class Api::PhotoTaggingsController < ApplicationController
  respond_to :json
  before_filter :ensure_owner_is_tagging, :only => [:create]

  def ensure_owner_is_tagging
    #a user must own the photo to tag
    #i.e. current user must be photo owner
    photo =  Photo.find(params[:photo_tagging][:photo_id])
    unless photo.owner_id == current_user.id
      render :json => {error: "Can only tag your own photo!"}
    end
  end

  def create
    @photo_tagging = PhotoTagging.new(params[:photo_tagging])
    if @photo_tagging.save
      render :json => @photo_tagging
    else
      render :json => @photo_tagging.errors, status: 422
    end
  end
end
