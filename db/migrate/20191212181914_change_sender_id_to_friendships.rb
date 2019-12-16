class ChangeSenderIdToFriendships < ActiveRecord::Migration[6.0]
  def change
    change_column :friendships, :sender_id, :integer, null: false
  end
end
