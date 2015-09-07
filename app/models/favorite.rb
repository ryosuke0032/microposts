class Favorite < ActiveRecord::Base
  belongs_to :favoriter, class_name: "User"
  belongs_to :favoritepost, class_name: "Micropost"
end
