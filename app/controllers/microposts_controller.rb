class MicropostsController < ApplicationController
 before_action :logged_in_user, only: [:create]

 def create
  @micropost = current_user.microposts.build(micropost_params)
  if @micropost.save
   flash[:success] = "Micropost created!"
   redirect_to root_url
  else
      @feed_items =  current_user.feed_items.includes(:user).order(created_at: :desc).page params[:page]
      @following = current_user.following_users
      @follower = current_user.follower_users
      @favorite = current_user.favorite_microposts
   render 'static_pages/home'
  end
 end

 def destroy
  @micropost = current_user.microposts.find_by(id: params[:id])
  return redirect_to root_url if @micropost.nil?
  @micropost.destroy
  flash[:success] = "Micropost deleted"
  redirect_to request.referrer || root_url
 end
 
 def retweet
  @origin = Micropost.find(params[:id]) 
  @micropost = current_user.microposts.build(content:@origin.content, origin:@origin)
  if @micropost.save
   flash[:success] = "Retweet created!"
   redirect_to root_url
  else
   render 'static_page/home'
  end
 end
 
     
  def favorite
    @micropost = Micropost.find(params[:id])
    current_user.favorite(@micropost)
    redirect_to (:back)
  end

  def unfavorite
    @micropost = current_user.favorite_microposts.find(params[:id])
    current_user.unfavorite(@micropost)
    redirect_to (:back)
  end
  
  
  
 private
  def micropost_params
	params.require(:micropost).permit(:content,:image,:image_cache)
  end
  
end
