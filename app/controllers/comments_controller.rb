class CommentsController < ApplicationController
  before_action :sign_up_if_not_logged_in

  def create
    post = Post.find(params[:comment][:post_id])
    if post
      post.comments.create(content: params[:comment][:content],
                           user_id: current_user.id)
    end
    redirect_back(fallback_location: root_path)
  end
end
