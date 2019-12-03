# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'associations for 1 post created by a user' do
    before :example do
      @user = User.create!(name: 'Dev',
                           email: 'dev1980@gmail.com',
                           password: 'password123',
                           password_confirmation: 'password123')

      @post = Post.create!(content: 'This is the content of post 1',
                           user_id: @user.id)
    end

    it 'the post can access to the creator' do
      expect(@post.user).to eq(@user)
    end
  end

  context 'validations for a new post' do
    before :example do
      @user = User.create!(name: 'Dev',
                           email: 'dev1980@gmail.com',
                           password: 'password123',
                           password_confirmation: 'password123')

      @post = Post.new(content: 'This is the content of post 1',
                       user_id: @user.id)
    end

    it 'checks that post must be valid' do
      expect(@post.valid?).to eq(true)
    end

    it 'checks that content must be present' do
      @post.content = ''
      expect(@post.valid?).to eq(false)
    end

    it 'checks that content must be < 500 characters' do
      @post.content = 'a' * 501
      expect(@post.valid?).to eq(false)
    end

    it 'checks that a posts group must be sorted by newest to oldest' do
      @post.save
      post2 = Post.create(content: 'This is the content of post 2',
                          user_id: @user.id)

      expect(Post.all).to eq([post2, @post])
    end
  end
end
