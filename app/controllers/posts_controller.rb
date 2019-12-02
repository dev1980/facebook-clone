class PostsController < ApplicationController
  before_action :sign_up_if_not_logged_in
  def index
    @posts = Post.all
  end

  def show
  end

  def new
  end

  def destroy
  end
end
