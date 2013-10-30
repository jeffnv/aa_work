class PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts
  end
  
  def create
    @post = Post.create!(params[:post])
    render json: @post
  end
  
  def root
    render :root
  end
end
