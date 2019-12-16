class ChangeReceiverIdToFriendships < ActiveRecord::Migration[6.0]
  def change
    change_column :friendships, :receiver_id, :integer, null: false
  end
end
