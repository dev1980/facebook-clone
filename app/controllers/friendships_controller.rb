class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    if user
      current_user.send_friend_request(user)
      redirect_back(fallback_location: root_path)
    end
  end
end
