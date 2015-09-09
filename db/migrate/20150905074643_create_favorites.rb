class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :favoriter_id, index: true, foreign_key: true
      t.integer :favoritepost_id, index: true, foreign_key: true
      t.timestamps null: false
      t.index [:favoriter_id, :favoritepost_id], unique: true
    end
  end
end
