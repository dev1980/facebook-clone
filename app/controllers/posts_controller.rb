# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path
    else
      redirect_to new_post_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
