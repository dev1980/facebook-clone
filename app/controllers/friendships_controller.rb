class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    if user
      current_user.send_friend_request(user)
      redirect_back(fallback_location: root_path)
    end
  end
  def update 
    user = User.find(params[:id])
    if user
      current_user.confirm_friend(user)
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @friend_requests = current_user.friend_requests
  end
end
