class UsersController < ApplicationController
  before_action :sign_up_if_not_logged_in
  def index
    @users = User.all
  end

  def show
  end

  def destroy
  end
end
