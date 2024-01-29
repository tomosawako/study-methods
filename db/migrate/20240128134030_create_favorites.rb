class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :enduser, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.index [:enduser_id, :post_id], unique: true

      t.timestamps
    end
  end
end
