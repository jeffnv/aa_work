class CommentsController < ApplicationController
  def new
  end

  def show
    @parent = Comment.find(params[:id])
    @comment = Comment.new
    render :show
  end

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
    else
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to link_url(params[:comment][:link_id])
  end
end
