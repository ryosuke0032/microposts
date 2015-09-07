class User < ActiveRecord::Base
      before_save { self.email = email.downcase }
      validates :name, presence: true, length: { maximum: 50 }
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :microposts
  
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  has_many :favoritelist, class_name:  "Favorite",
                                     foreign_key: "favoriter_id",
                                     dependent:   :destroy
                                     
  has_many :favorite_microposts, through: :favoritelist, source: :favoritepost
  
  mount_uploader :avatar, AvatarUploader
    # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  
  #お気に入りに登録する
  def favorite(other_post)
    favoritelist.create(favoritepost_id: other_post.id )
  end
  
  def unfavorite(other_post)
    favoritelist.find_by(favoritepost_id: other_post.id).destroy
  end
  
  def favorite?(other_post)
    favorite_microposts.include?(other_post)
  end
  
end
