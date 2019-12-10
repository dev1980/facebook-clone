# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Friendships', type: :feature do
  context '2 users are not friends' do
    before :example do
      @user1 = User.create!(name: 'Dev', email: 'dev1980@gmail.com',
                            password: 'password123', password_confirmation: 'password123')

      @user2 = User.create!(name: 'Marya', email: 'marya@gmail.com',
                            password: 'password123', password_confirmation: 'password123')

      sign_in @user1
    end
    it 'user can visit user profile and send friend reqeust' do
      visit(user_path(@user2))
      expect do
        click_link 'Send Friend Request'
        @user2.reload
      end .to change { @user2.friend_requests.count }.by(1)
    end
    it 'user can accept the friend request' do
      @user2.send_friend_request(@user1)
      @user1.reload
      visit(friendships_path)
      expect do
        click_link 'Accept Friend Request'
        @user1.reload
      end .to change { @user1.friends.count }.by(1)
    end
  end
end
