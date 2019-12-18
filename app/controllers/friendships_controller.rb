# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find_by_id(params[:user_id])
    return unless user

    current_user.send_friend_request(user)
    redirect_back(fallback_location: root_path)
  end

  def update
    user = User.find_by_id(params[:id])
    return unless user

    current_user.confirm_friend(user)
    redirect_back(fallback_location: root_path)
  end

  def index
    @friend_requests = current_user.friend_requests
  end
end
