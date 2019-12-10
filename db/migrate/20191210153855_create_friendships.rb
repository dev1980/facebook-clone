class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :confirmed

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :sender_id
    add_foreign_key :friendships, :users, column: :receiver_id
  end
end
