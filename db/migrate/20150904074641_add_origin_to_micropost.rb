class AddOriginToMicropost < ActiveRecord::Migration
  def change
    add_reference :microposts, :origin, index: true, foreign_key: true
  end
end
