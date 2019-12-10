# frozen_string_literal: true

module FriendshipsHelper
  def friend_status(user)
    return unless current_user != user

    if current_user.friend? user
      'You are already friends'
    elsif current_user.pending_friends.include? user
      'Waiting for Friend Response'
    elsif current_user.friend_requests.include? user
      link_to 'Accept Friend Request', friendship_path(id: user.id), method: :patch
    else
      link_to 'Send Friend Request', friendships_path(user_id: user.id), method: :post
    end
  end
end
