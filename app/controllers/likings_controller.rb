# frozen_string_literal: true

class LikingsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find_by_id(params[:post_id])
    current_user.like post if post
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find_by_id(params[:id])
    current_user.dislike post if post
    redirect_back(fallback_location: root_path)
  end
end
