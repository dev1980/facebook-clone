# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :sign_up_if_not_logged_in
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
  end
end
