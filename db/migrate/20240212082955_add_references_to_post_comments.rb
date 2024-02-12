class AddReferencesToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :post_comments, :parent, foreign_key: { to_table: :post_comments}
  end
end
