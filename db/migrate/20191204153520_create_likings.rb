class CreateLikings < ActiveRecord::Migration[6.0]
  def change
    create_table :likings do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :likings, :posts
    add_foreign_key :likings, :users
  end
end
