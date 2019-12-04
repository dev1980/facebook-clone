class AddIndexToLikings < ActiveRecord::Migration[6.0]
  def change
    add_index :likings, [:user_id, :post_id], unique: true
  end
end
