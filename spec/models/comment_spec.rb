# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'associations for 1 post created by a user' do
    before :example do
      @user = User.create!(name: 'Dev',
                           email: 'dev1980@gmail.com',
                           password: 'password123',
                           password_confirmation: 'password123')

      @post = Post.create!(content: 'This is the content of post 1',
                           user_id: @user.id)

      @comment = Comment.create!(content: 'This is the content of comment 1',
                                 post_id: @post.id,
                                 user_id: @user.id)
    end

    it 'the comment can access to the creator' do
      expect(@comment.user).to eq(@user)
    end

    it 'the comment can access to the post' do
      expect(@comment.post).to eq(@post)
    end
  end

  context 'validations for a new comment' do
    before :example do
      @user = User.create!(name: 'Dev', email: 'dev1980@gmail.com',
                           password: 'password123', password_confirmation: 'password123')

      @post = Post.create!(content: 'This is the content of post 1',
                           user_id: @user.id)

      @comment = Comment.new(content: 'This is the content of comment 1', post_id: @post.id, user_id: @user.id)
    end

    it 'checks that comment must be valid' do
      expect(@comment.valid?).to eq(true)
    end

    it 'checks that content must be present' do
      @comment.content = ''
      expect(@comment.valid?).to eq(false)
    end

    it 'checks that content must be < 250 characters' do
      @comment.content = 'a' * 251
      expect(@comment.valid?).to eq(false)
    end

    it 'checks that a comments group must be sorted by newest to oldest' do
      @comment.save
      comment2 = Comment.create(content: 'This is the content of comment 2', user_id: @user.id, post_id: @post.id)

      expect(Comment.all).to eq([comment2, @comment])
    end
  end
end
