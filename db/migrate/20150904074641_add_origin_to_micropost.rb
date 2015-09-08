class AddOriginToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :origin_id, :integer
    add_index :microposts, :origin_id
  end
end
