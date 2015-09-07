class UsersController < ApplicationController
  before_action :set_user, only:[:show,:edit,:update,:followings,:followers,:favorites]
  
  def show
      @microposts = @user.microposts.order(created_at: :desc).page params[:page]
      @following = @user.following_users
      @follower = @user.follower_users
  end
  
  def new
    @user = User.new
  end
  
  def edit
  end
  
  def update
   if @user.update(user_params)
      flash[:success] = "プロフィールを編集しました"
      redirect_to @user
    else
      render 'edit'
   end
  end
  
  def create
   @user = User.new(user_params)
   if @user.save
     flash[:success] = "Welcome to the Sample App!"
     redirect_to @user
   else
  	render 'new'
   end
  end
 
  def followings
     @following = @user.following_users
  end
  
  def followers
      @follower = @user.follower_users
  end
  
  def favorites
     @favorite = @user.favorite_microposts.order(created_at: :desc).page params[:page]
  end

private

  def user_params
	 params.require(:user).permit(:name,:email,:password,:password_confirmation,:description,:location,:avatar)
  end

  def set_user
   @user = User.find(params[:id]) 
  end
end
