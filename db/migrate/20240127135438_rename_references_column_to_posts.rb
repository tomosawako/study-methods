class RenameReferencesColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :references, :reference_book
  end
end
