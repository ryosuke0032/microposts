class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  paginates_per 5
  belongs_to :origin, class_name: "Micropost"
  
  has_many :favoriteuserlist, class_name:  "Favorite",
                                     foreign_key: "favoritepost_id",
                                     dependent:   :destroy
                                     
  has_many :favorite_user, through: :favoriteuserlist, source: :favoriter
  mount_uploader :image, ImageUploader
end
