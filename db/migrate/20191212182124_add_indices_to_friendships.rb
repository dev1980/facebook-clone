class AddIndicesToFriendships < ActiveRecord::Migration[6.0]
  def change
    add_index :friendships, :sender_id
    add_index :friendships, :receiver_id
    add_index :friendships, [:sender_id, :receiver_id], unique: true
  end
end
