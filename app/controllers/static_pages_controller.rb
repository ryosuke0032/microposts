class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items =  current_user.feed_items.includes(:user).order(created_at: :desc).page params[:page]
      @following = current_user.following_users
      @follower = current_user.follower_users
    end
  end
end
