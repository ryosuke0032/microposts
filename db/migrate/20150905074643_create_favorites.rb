class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :favoriter, index: true, foreign_key: true
      t.references :favoritepost, index: true, foreign_key: true

      t.timestamps null: false
      t.index [:favoriter_id, :favoritepost_id], unique: true
    end
  end
end
