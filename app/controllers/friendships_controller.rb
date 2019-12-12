# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:user_id])
    return unless user

    current_user.send_friend_request(user)
    redirect_back(fallback_location: root_path)
  end

  def update
    user = User.find(params[:id])
    return unless user

    current_user.confirm_friend(user)
    Friendship.create sender_id: user.id, receiver_id: current_user.id, confirmed: true
    redirect_back(fallback_location: root_path)
  end

  def index
    @friend_requests = current_user.friend_requests
  end
end
