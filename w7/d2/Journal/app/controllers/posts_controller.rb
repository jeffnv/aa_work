class PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts
  end
  
  def create
    @post = Post.new(params[:post])
    if(@post.save)
      render json: @post
    else
      render json: @post.errors
    end
  end
  
  def update
    @post = Post.find(params[:id]);
    if @post.update_attributes(params[:post])
      render json: @post
    else
      render json: @post.errors, status: true
    end
  end
  
  def root
    render :root
  end
end
