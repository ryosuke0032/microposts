class FavoritesController < ApplicationController
    
  def create
    @micropost = Micropost.find(params[:id])
    current_user.favorite(@micropost)
  end

  def destroy
    @micropost = current_user.favorite_microposts.find(params[:id]).favoritepost
    current_user.unfavorite(@micropost)
  end
  
  
end
