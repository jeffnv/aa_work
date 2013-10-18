class LinksController < ApplicationController
  def new
    @link = Link.new
    render :new
  end

  def create
    @link = Link.new(params[:link])
    if @link.save
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.new
    @link = Link.find(params[:id])
    @comments = @link.comments
    @comment_string = render_comments(@comments.where("comments.parent_comment_id IS NULL"))
    render :show
  end

  def index
    @links = Link.all
    render :index
  end

  def render_comments(comments)
    comment_string = ""
    if comments.empty?
      return comment_string
    else
      comment_string << "<ul>"
      comments.each do |comment|
        comment_string << "<li>#{comment.body}</li>"
        comment_string += render_comments(comment.child_comments)
      end
      comment_string << "</ul>"
    end

     comment_string
  end
end
