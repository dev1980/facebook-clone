class LikingsController < ApplicationController
  before_action :sign_up_if_not_logged_in

  def create
    post = Post.find(params[:post_id])
    current_user.like post if post
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:id])
    current_user.dislike post if post
    redirect_back(fallback_location: root_path)
  end
end
