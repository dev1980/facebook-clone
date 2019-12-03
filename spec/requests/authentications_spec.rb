# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentications', type: :feature do
  context 'for a not logged-in user' do
    it 'can signup' do
      visit '/users/sign_up'
      fill_in 'Name', with: 'A Name'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      expect { click_button 'Sign up' }.to change { User.all.count }.by(1)
    end

    it 'cannot access to post index' do
      visit '/'
      expect(page.current_path).to eq('/users/sign_up')
    end

    it 'cannot access to create a new post' do
      visit '/posts/new'
      expect(page.current_path).to eq('/users/sign_up')
    end

    it 'cannot see a user profile' do
      user = User.create!(name: 'Dev', email: 'dev1980@gmail.com', password: 'password123',
                          password_confirmation: 'password123')
      visit user
      expect(page.current_path).to eq('/users/sign_up')
    end
  end

  context 'for a logged-in user' do
    before :example do
      @user = User.create!(name: 'Dev', email: 'dev1980@gmail.com', password: 'password123',
                           password_confirmation: 'password123')
      sign_in @user
    end

    it 'can create a post' do
      visit '/posts/new'
      fill_in 'post[content]', with: 'This is the Content of a Post'
      expect { click_button 'Create Post' }.to change { Post.all.count }.by(1)
    end

    it 'can see a user profile' do
      visit user_path(@user)
      expect(page.current_path).to eq(user_path(@user))
    end

    it 'can see a post' do
      post = Post.create!(content: 'This is the content of a Post', user_id: @user.id)
      visit post_path(post)
      expect(page.current_path).to eq(post_path(post))
    end

    it 'can see the posts index' do
      visit '/'
      expect(page.current_path).to eq('/')
    end
  end
end
