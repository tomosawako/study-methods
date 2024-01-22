class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :enduser_id, null: false
      t.integer :category_id, null:false
      t.string :field, null: false
      t.string :references, null: false
      t.text :study_method, null: false
      t.integer :total_study_time, null: false
      t.text :achievement, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
