# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :sign_up_if_not_logged_in
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
