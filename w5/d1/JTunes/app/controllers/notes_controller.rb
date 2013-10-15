class NotesController < ApplicationController
  
  def create
    @note = Note.new(params[:note])
    
    unless @note.save
      flash[:errors] = @note.errors.full_messages
    end
    
    redirect_to track_url(params[:track_id])
  end
  
  def destroy
    track = Note.find(params[:id]).track_id
    Note.delete(params[:id])
    redirect_to track_url(track)
  end
  
end
