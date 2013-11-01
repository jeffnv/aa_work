class FavoritesController < ApplicationController

  def create
    @favorite = current_user.favorites.create({gist_id: params[:gist_id]})
    if @favorite.save
      render :json => @favorite
    else
      render :json => @favorite.errors.full_messages, :status => 422
    end
  end

  def destroy
    @favorite = Favorite.find_by_gist_id_and_user_id(params[:gist_id], current_user.id)
    @favorite.destroy()
    render :json => @favorite
  end

  def index
    render :json => current_user.favorites
  end

end
